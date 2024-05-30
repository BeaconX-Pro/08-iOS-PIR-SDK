//
//  MKCQPirHallSensorModel.m
//  MKBeaconPirSensor_Example
//
//  Created by aa on 2024/5/30.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import "MKCQPirHallSensorModel.h"

#import "MKMacroDefines.h"

#import "MKCQInterface.h"
#import "MKCQInterface+MKCQConfig.h"

#import "MKCQDeviceTimeDataModel.h"

@interface MKCQPirHallSensorModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKCQPirHallSensorModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        
        if (![self readSensitivity]) {
            [self operationFailedBlockWithMsg:@"Read Sensitivity Error" block:failedBlock];
            return;
        }
        
        if (![self readDelay]) {
            [self operationFailedBlockWithMsg:@"Read Delay Error" block:failedBlock];
            return;
        }
        
        if (![self readDeviceTime]) {
            [self operationFailedBlockWithMsg:@"Read Device Time Error" block:failedBlock];
            return;
        }
        
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        
        if (![self configSensitivity]) {
            [self operationFailedBlockWithMsg:@"Config Sensitivity Error" block:failedBlock];
            return;
        }
        
        if (![self configDelay]) {
            [self operationFailedBlockWithMsg:@"Config Delay Error" block:failedBlock];
            return;
        }
        
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (void)syncDateWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        
        if (![self configDeviceTime]) {
            [self operationFailedBlockWithMsg:@"Sync Date Time Error" block:failedBlock];
            return;
        }
        
        sleep(1);
        
        if (![self readDeviceTime]) {
            [self operationFailedBlockWithMsg:@"Read Device Time Error" block:failedBlock];
            return;
        }
        
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

#pragma mark - interface

- (BOOL)readSensitivity {
    __block BOOL success = NO;
    [MKCQInterface cq_readPIRSensorSensitivityWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.sensitivity = [returnData[@"result"][@"sensitivity"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configSensitivity {
    __block BOOL success = NO;
    [MKCQInterface cq_configPIRSensorSensitivity:self.sensitivity sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readDelay {
    __block BOOL success = NO;
    [MKCQInterface cq_readPIRSensorDelayWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.delay = [returnData[@"result"][@"delay"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configDelay {
    __block BOOL success = NO;
    [MKCQInterface cq_configPIRSensorDelay:self.delay sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readDeviceTime {
    __block BOOL success = NO;
    [MKCQInterface cq_readDeviceTimeWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        NSString *deviceTime = returnData[@"result"][@"deviceTime"];
        NSArray *dateList = [deviceTime componentsSeparatedByString:@" "];
        self.date = dateList[0];
        self.time = dateList[1];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
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
- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        NSError *error = [[NSError alloc] initWithDomain:@"SensorParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

#pragma mark - getter
- (dispatch_semaphore_t)semaphore {
    if (!_semaphore) {
        _semaphore = dispatch_semaphore_create(0);
    }
    return _semaphore;
}

- (dispatch_queue_t)readQueue {
    if (!_readQueue) {
        _readQueue = dispatch_queue_create("SensorQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
