//
//  MKCQDeviceInfoModel.m
//  MKBeaconPirSensor_Example
//
//  Created by aa on 2024/5/29.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import "MKCQDeviceInfoModel.h"

#import "MKMacroDefines.h"

#import "MKCQInterface.h"

@interface MKCQDeviceInfoModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKCQDeviceInfoModel

- (void)readWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readBatteryPower]) {
            [self operationFailedBlockWithMsg:@"Read battery power error" block:failedBlock];
            return ;
        }
        if (![self readMacAddress]) {
            [self operationFailedBlockWithMsg:@"Read mac address error" block:failedBlock];
            return ;
        }
        if (![self readProduce]) {
            [self operationFailedBlockWithMsg:@"Read product model error" block:failedBlock];
            return ;
        }
        if (![self readSoftware]) {
            [self operationFailedBlockWithMsg:@"Read software error" block:failedBlock];
            return ;
        }
        if (![self readFirmware]) {
            [self operationFailedBlockWithMsg:@"Read firmware error" block:failedBlock];
            return ;
        }
        if (![self readHardware]) {
            [self operationFailedBlockWithMsg:@"Read hardware error" block:failedBlock];
            return ;
        }
        if (![self readManuDate]) {
            [self operationFailedBlockWithMsg:@"Read manufacture date error" block:failedBlock];
            return ;
        }
        if (![self readManu]) {
            [self operationFailedBlockWithMsg:@"Read manufacture error" block:failedBlock];
            return ;
        }
        if (![self readRunningTime]) {
            [self operationFailedBlockWithMsg:@"Read running time error" block:failedBlock];
            return ;
        }
        if (![self readChipModel]) {
            [self operationFailedBlockWithMsg:@"Read chipset model error" block:failedBlock];
            return ;
        }
        
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

#pragma mark - interface
- (BOOL)readBatteryPower {
    __block BOOL success = NO;
    [MKCQInterface cq_readBatteryWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.battery = returnData[@"result"][@"valotage"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readMacAddress {
    __block BOOL success = NO;
    [MKCQInterface cq_readMacAddresWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.macAddress = returnData[@"result"][@"macAddress"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readProduce {
    __block BOOL success = NO;
    [MKCQInterface cq_readModeIDWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.produce = returnData[@"result"][@"modeID"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readSoftware {
    __block BOOL success = NO;
    [MKCQInterface cq_readSoftwareWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.software = returnData[@"result"][@"software"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readFirmware {
    __block BOOL success = NO;
    [MKCQInterface cq_readFirmwareWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.firmware = returnData[@"result"][@"firmware"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readHardware {
    __block BOOL success = NO;
    [MKCQInterface cq_readHardwareWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.hardware = returnData[@"result"][@"hardware"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readManuDate {
    __block BOOL success = NO;
    [MKCQInterface cq_readProductionDateWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.manuDate = returnData[@"result"][@"productionDate"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readManu {
    __block BOOL success = NO;
    [MKCQInterface cq_readVendorWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.manu = returnData[@"result"][@"vendor"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readRunningTime {
    __block BOOL success = NO;
    [MKCQInterface cq_readRunningTimeWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        NSInteger seconds = [returnData[@"result"][@"runningTime"] integerValue];
        
        NSInteger days = seconds / 86400;
        NSInteger hours = (seconds % 86400) / 3600;
        NSInteger minutes = ((seconds % 86400) % 3600) / 60;
        NSInteger remainingSeconds = ((seconds % 86400) % 3600) % 60;
        
        self.runningTime = [NSString stringWithFormat:@"%ldD%ldH%ldM%ldS",(long)days,(long)hours,(long)minutes,(long)remainingSeconds];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readChipModel {
    __block BOOL success = NO;
    [MKCQInterface cq_readChipsetModelWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.chipsetModel = returnData[@"result"][@"model"];
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
        NSError *error = [[NSError alloc] initWithDomain:@"deviceInformation"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    });
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
        _readQueue = dispatch_queue_create("deviceInfoParamsQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
