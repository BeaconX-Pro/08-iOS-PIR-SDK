//
//  MKCQConnectManager.m
//  MKBeaconPirSensor_Example
//
//  Created by aa on 2021/2/24.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKCQConnectManager.h"

#import <CoreBluetooth/CoreBluetooth.h>

#import "MKMacroDefines.h"

#import "MKCQCentralManager.h"
#import "MKCQInterface+MKCQConfig.h"

#import "MKCQDeviceTimeDataModel.h"

@interface MKCQConnectManager ()

@property (nonatomic, strong)dispatch_queue_t connectQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKCQConnectManager

+ (MKCQConnectManager *)shared {
    static MKCQConnectManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [[MKCQConnectManager alloc] init];
        }
    });
    return manager;
}

- (void)connectPeripheral:(CBPeripheral *)peripheral
                 password:(NSString *)password
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.connectQueue, ^{
        NSDictionary *dic = [self connectDevice:peripheral password:password];
        if (![dic[@"success"] boolValue]) {
            [self operationFailedMsg:dic[@"msg"] completeBlock:failedBlock];
            return ;
        }
        
//        if (![self configDeviceTime]) {
//            [self operationFailedMsg:@"Sync Time Error" completeBlock:failedBlock];
//            return;
//        }
//        sleep(1);
        
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

#pragma mark - interface
- (NSDictionary *)connectDevice:(CBPeripheral *)peripheral password:(NSString *)password {
    __block NSDictionary *connectResult = @{};
    
    [[MKCQCentralManager shared] connectPeripheral:peripheral password:password sucBlock:^(CBPeripheral * _Nonnull peripheral) {
        connectResult = @{
            @"success":@(YES),
        };
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        connectResult = @{
            @"success":@(NO),
            @"msg":SafeStr(error.userInfo[@"errorInfo"]),
        };
        dispatch_semaphore_signal(self.semaphore);
    }];
    
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return connectResult;
}

- (BOOL)configDeviceTime {
    __block BOOL success = NO;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
    NSString *date = [formatter stringFromDate:[NSDate date]];
    NSArray *dateList = [date componentsSeparatedByString:@"-"];
    
    MKCQDeviceTimeDataModel *dateModel = [[MKCQDeviceTimeDataModel alloc] init];
    dateModel.year = [dateList[0] integerValue];
    dateModel.month = [dateList[1] integerValue];
    dateModel.day = [dateList[2] integerValue];
    dateModel.hour = [dateList[3] integerValue];
    dateModel.minutes = [dateList[4] integerValue];
    dateModel.seconds = [dateList[5] integerValue];
    
    [MKCQInterface cq_configDeviceTime:dateModel sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

#pragma mark - private method
- (void)operationFailedMsg:(NSString *)msg completeBlock:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        [[MKCQCentralManager shared] disconnect];
        if (block) {
            NSError *error = [[NSError alloc] initWithDomain:@"connectDevice"
                                                        code:-999
                                                    userInfo:@{@"errorInfo":SafeStr(msg)}];
            block(error);
        }
    });
}

#pragma mark - getter
- (dispatch_queue_t)connectQueue {
    if (!_connectQueue) {
        _connectQueue = dispatch_queue_create("com.moko.connectQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _connectQueue;
}

- (dispatch_semaphore_t)semaphore {
    if (!_semaphore) {
        _semaphore = dispatch_semaphore_create(0);
    }
    return _semaphore;
}

@end
