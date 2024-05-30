//
//  MKCQAdvertisementModel.m
//  MKBeaconPirSensor_Example
//
//  Created by aa on 2024/5/28.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import "MKCQAdvertisementModel.h"

#import "MKMacroDefines.h"

#import "MKCQInterface.h"
#import "MKCQInterface+MKCQConfig.h"

@interface MKCQAdvertisementModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKCQAdvertisementModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        
        if (![self readMajor]) {
            [self operationFailedBlockWithMsg:@"Read Major Error" block:failedBlock];
            return;
        }
        
        if (![self readMinor]) {
            [self operationFailedBlockWithMsg:@"Read Minor Error" block:failedBlock];
            return;
        }
        
        if (![self readDeviceName]) {
            [self operationFailedBlockWithMsg:@"Read Device Name Error" block:failedBlock];
            return;
        }
        
        if (![self readSerialId]) {
            [self operationFailedBlockWithMsg:@"Read Serial ID Error" block:failedBlock];
            return;
        }
        
        if (![self readAdvInterval]) {
            [self operationFailedBlockWithMsg:@"Read Adv Interval Error" block:failedBlock];
            return;
        }
        
        if (![self readRssi]) {
            [self operationFailedBlockWithMsg:@"Read RSSI Error" block:failedBlock];
            return;
        }
        
        if (![self readTxPower]) {
            [self operationFailedBlockWithMsg:@"Read Tx Power Error" block:failedBlock];
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
        
        if (![self validParams]) {
            [self operationFailedBlockWithMsg:@"Opps！Save failed. Please check the input characters and try again." block:failedBlock];
            return;
        }
        
        if (![self configMajor]) {
            [self operationFailedBlockWithMsg:@"Config Major Error" block:failedBlock];
            return;
        }
        
        if (![self configMinor]) {
            [self operationFailedBlockWithMsg:@"Config Minor Error" block:failedBlock];
            return;
        }
        
        if (![self configDeviceName]) {
            [self operationFailedBlockWithMsg:@"Config Device Name Error" block:failedBlock];
            return;
        }
        
        if (![self configSerialId]) {
            [self operationFailedBlockWithMsg:@"Config Serial ID Error" block:failedBlock];
            return;
        }
        
        if (![self configAdvInterval]) {
            [self operationFailedBlockWithMsg:@"Config Adv Interval Error" block:failedBlock];
            return;
        }
        
        if (![self configRssi]) {
            [self operationFailedBlockWithMsg:@"Config RSSI Error" block:failedBlock];
            return;
        }
        
        if (![self configTxPower]) {
            [self operationFailedBlockWithMsg:@"Config Tx Power Error" block:failedBlock];
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

- (BOOL)readMajor {
    __block BOOL success = NO;
    [MKCQInterface cq_readMajorWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.major = returnData[@"result"][@"major"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configMajor {
    __block BOOL success = NO;
    [MKCQInterface cq_configMajor:[self.major integerValue] sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readMinor {
    __block BOOL success = NO;
    [MKCQInterface cq_readMinorWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.minor = returnData[@"result"][@"minor"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configMinor {
    __block BOOL success = NO;
    [MKCQInterface cq_configMinor:[self.minor integerValue] sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readDeviceName {
    __block BOOL success = NO;
    [MKCQInterface cq_readDeviceNameWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.deviceName = returnData[@"result"][@"deviceName"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configDeviceName {
    __block BOOL success = NO;
    [MKCQInterface cq_configDeviceName:self.deviceName sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readSerialId {
    __block BOOL success = NO;
    [MKCQInterface cq_readSerialIdWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.serialId = returnData[@"result"][@"serialId"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configSerialId {
    __block BOOL success = NO;
    [MKCQInterface cq_configSerialId:self.serialId sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readAdvInterval {
    __block BOOL success = NO;
    [MKCQInterface cq_readAdvIntervalWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.advInterval = returnData[@"result"][@"interval"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configAdvInterval {
    __block BOOL success = NO;
    [MKCQInterface cq_configAdvInterval:[self.advInterval integerValue] sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readRssi {
    __block BOOL success = NO;
    [MKCQInterface cq_readRssiWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.rssi1m = [returnData[@"result"][@"rssi"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configRssi {
    __block BOOL success = NO;
    [MKCQInterface cq_configRssi:self.rssi1m sucBlock:^(id  _Nonnull returnData) {
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readTxPower {
    __block BOOL success = NO;
    [MKCQInterface cq_readTxPowerWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.txPower = [self getTxPowerValue:returnData[@"result"][@"txPower"]];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configTxPower {
    __block BOOL success = NO;
    [MKCQInterface cq_configTxPower:[self txPowerExchanged] sucBlock:^(id  _Nonnull returnData) {
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
        NSError *error = [[NSError alloc] initWithDomain:@"BleParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (BOOL)validParams {
    if (!ValidStr(self.major) || [self.major integerValue] < 0 || [self.major integerValue] > 65535) {
        return NO;
    }
    
    if (!ValidStr(self.minor) || [self.minor integerValue] < 0 || [self.minor integerValue] > 65535) {
        return NO;
    }
    
    if (!ValidStr(self.deviceName) || self.deviceName.length > 10) {
        return NO;
    }
    
    if (!ValidStr(self.serialId) || self.serialId.length > 5) {
        return NO;
    }
    
    if (!ValidStr(self.advInterval) || [self.advInterval integerValue] < 1 || [self.advInterval integerValue] > 100) {
        return NO;
    }
    
    return YES;
}

- (NSInteger)getTxPowerValue:(NSString *)power {
    if ([power isEqualToString:@"0"]) {
        return 7;
    }
    if ([power isEqualToString:@"1"]) {
        return 6;
    }
    if ([power isEqualToString:@"2"]) {
        return 5;
    }
    if ([power isEqualToString:@"3"]) {
        return 4;
    }
    if ([power isEqualToString:@"4"]) {
        return 3;
    }
    if ([power isEqualToString:@"5"]) {
        return 2;
    }
    if ([power isEqualToString:@"6"]) {
        return 1;
    }
    
    return 0;
}

- (mk_cq_slotRadioTxPower)txPowerExchanged {
    if (self.txPower == 0) {
        return mk_cq_slotRadioTxPowerNeg40dBm;
    }
    if (self.txPower == 1) {
        return mk_cq_slotRadioTxPowerNeg20dBm;
    }
    if (self.txPower == 2) {
        return mk_cq_slotRadioTxPowerNeg16dBm;
    }
    if (self.txPower == 3) {
        return mk_cq_slotRadioTxPowerNeg12dBm;
    }
    if (self.txPower == 4) {
        return mk_cq_slotRadioTxPowerNeg8dBm;
    }
    if (self.txPower == 5) {
        return mk_cq_slotRadioTxPowerNeg4dBm;
    }
    if (self.txPower == 6) {
        return mk_cq_slotRadioTxPower0dBm;
    }
    return mk_cq_slotRadioTxPower4dBm;
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
        _readQueue = dispatch_queue_create("BleQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
