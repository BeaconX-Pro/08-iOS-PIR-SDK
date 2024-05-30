//
//  MKCQInterface+MKCQConfig.m
//  MKBeaconPirSensor_Example
//
//  Created by aa on 2021/2/23.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKCQInterface+MKCQConfig.h"

#import "MKBLEBaseSDKDefines.h"
#import "MKBLEBaseSDKAdopter.h"

#import "CBPeripheral+MKCQAdd.h"
#import "MKCQCentralManager.h"
#import "MKCQOperationID.h"
#import "MKCQAdopter.h"

#define centralManager [MKCQCentralManager shared]
#define peripheral [MKCQCentralManager shared].peripheral

@implementation MKCQInterface (MKCQConfig)

+ (void)cq_configMajor:(NSInteger)major
              sucBlock:(void (^)(id returnData))sucBlock
           failedBlock:(void (^)(NSError *error))failedBlock {
    if (major < 0 || major > 65535) {
        [self operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:major byteLen:2];
    [centralManager addTaskWithTaskID:mk_cq_taskConfigMajorOperation
                          commandData:value
                       characteristic:peripheral.cq_major
                             sucBlock:sucBlock
                          failedBlock:failedBlock];
}

+ (void)cq_configMinor:(NSInteger)minor
              sucBlock:(void (^)(id returnData))sucBlock
           failedBlock:(void (^)(NSError *error))failedBlock {
    if (minor < 0 || minor > 65535) {
        [self operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:minor byteLen:2];
    [centralManager addTaskWithTaskID:mk_cq_taskConfigMinorOperation
                          commandData:value
                       characteristic:peripheral.cq_minor
                             sucBlock:sucBlock
                          failedBlock:failedBlock];
}

+ (void)cq_configRssi:(NSInteger)rssi
             sucBlock:(void (^)(id returnData))sucBlock
          failedBlock:(void (^)(NSError *error))failedBlock {
    if (rssi < -100 || rssi > 0) {
        [self operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:(-1 * rssi) byteLen:1];
    [centralManager addTaskWithTaskID:mk_cq_taskConfigRssiOperation
                          commandData:value
                       characteristic:peripheral.cq_rssi
                             sucBlock:sucBlock
                          failedBlock:failedBlock];
}

+ (void)cq_configTxPower:(mk_cq_slotRadioTxPower)txPower
                sucBlock:(void (^)(id returnData))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:txPower byteLen:1];
    [centralManager addTaskWithTaskID:mk_cq_taskConfigTxPowerOperation
                          commandData:value
                       characteristic:peripheral.cq_txPower
                             sucBlock:sucBlock
                          failedBlock:failedBlock];
}

+ (void)cq_modifyPassword:(NSString *)password
                 sucBlock:(void (^)(id returnData))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock {
    if (!MKValidStr(password) || password.length != 8) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *commandData = @"";
    for (NSInteger i = 0; i < password.length; i ++) {
        int asciiCode = [password characterAtIndex:i];
        commandData = [commandData stringByAppendingString:[NSString stringWithFormat:@"%1lx",(unsigned long)asciiCode]];
    }
    [centralManager addTaskWithTaskID:mk_cq_taskChangePasswordOperation
                          commandData:commandData
                       characteristic:peripheral.cq_password
                             sucBlock:sucBlock
                          failedBlock:failedBlock];
}

+ (void)cq_configAdvInterval:(NSInteger)interval
                    sucBlock:(void (^)(id returnData))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock {
    if (interval < 1 || interval > 100) {
        [self operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:interval byteLen:1];
    [centralManager addTaskWithTaskID:mk_cq_taskConfigAdvIntervalOperation
                          commandData:value
                       characteristic:peripheral.cq_advInterval
                             sucBlock:sucBlock
                          failedBlock:failedBlock];
}

+ (void)cq_configSerialId:(NSString *)serialId
                 sucBlock:(void (^)(id returnData))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock {
    if (!MKValidStr(serialId) || serialId.length > 5 || ![MKCQAdopter isRealNumber:serialId]) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *commandData = @"";
    for (NSInteger i = 0; i < serialId.length; i ++) {
        int asciiCode = [serialId characterAtIndex:i];
        commandData = [commandData stringByAppendingString:[NSString stringWithFormat:@"%1lx",(unsigned long)asciiCode]];
    }
    [centralManager addTaskWithTaskID:mk_cq_taskConfigSerialIdOperation
                          commandData:commandData
                       characteristic:peripheral.cq_serialId
                             sucBlock:sucBlock
                          failedBlock:failedBlock];
}

+ (void)cq_configDeviceName:(NSString *)deviceName
                   sucBlock:(void (^)(id returnData))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock {
    if (!MKValidStr(deviceName) || deviceName.length > 10) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *commandData = @"";
    for (NSInteger i = 0; i < deviceName.length; i ++) {
        int asciiCode = [deviceName characterAtIndex:i];
        commandData = [commandData stringByAppendingString:[NSString stringWithFormat:@"%1lx",(unsigned long)asciiCode]];
    }
    [centralManager addTaskWithTaskID:mk_cq_taskConfigDeviceNameOperation
                          commandData:commandData
                       characteristic:peripheral.cq_deviceName
                             sucBlock:sucBlock
                          failedBlock:failedBlock];
}

+ (void)cq_configConnectStatus:(BOOL)connectEnable
                       sucBlock:(void (^)(id returnData))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addTaskWithTaskID:mk_cq_taskConfigConnectableOperation
                          commandData:(connectEnable ? @"00" : @"01")
                       characteristic:peripheral.cq_connectable
                             sucBlock:sucBlock
                          failedBlock:failedBlock];
}

+ (void)cq_factoryDataResetWithPassword:(NSString *)password
                               sucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    if (!MKValidStr(password) || password.length != 8) {
        [MKBLEBaseSDKAdopter operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *commandData = @"";
    for (NSInteger i = 0; i < password.length; i ++) {
        int asciiCode = [password characterAtIndex:i];
        commandData = [commandData stringByAppendingString:[NSString stringWithFormat:@"%1lx",(unsigned long)asciiCode]];
    }
    [centralManager addTaskWithTaskID:mk_cq_taskFactoryResetOperation
                          commandData:commandData
                       characteristic:peripheral.cq_reset
                             sucBlock:sucBlock
                          failedBlock:failedBlock];
}

+ (void)cq_configPowerOffWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addTaskWithTaskID:mk_cq_taskConfigPowerOffOperation
                          commandData:@"ea6d000100"
                       characteristic:peripheral.cq_custom
                             sucBlock:sucBlock
                          failedBlock:failedBlock];
}

+ (void)cq_configButtonPowerStatus:(BOOL)isOn
                           sucBlock:(void (^)(id returnData))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = (isOn ? @"ea70000101" : @"ea70000100");
    [centralManager addTaskWithTaskID:mk_cq_taskConfigButtonPowerStatusOperation
                          commandData:commandString
                       characteristic:peripheral.cq_custom
                             sucBlock:sucBlock
                          failedBlock:failedBlock];
}

+ (void)cq_configPIRSensorSensitivity:(mk_cq_pirSensorDegree)sensitivity
                             sucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:sensitivity byteLen:1];
    NSString *commandString = [@"ea720001" stringByAppendingString:value];
    [centralManager addTaskWithTaskID:mk_cq_taskConfigPIRSensorSensitivityOperation
                          commandData:commandString
                       characteristic:peripheral.cq_custom
                             sucBlock:sucBlock
                          failedBlock:failedBlock];
}

+ (void)cq_configPIRSensorDelay:(mk_cq_pirSensorDegree)delay
                       sucBlock:(void (^)(id returnData))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *value = [MKBLEBaseSDKAdopter fetchHexValue:delay byteLen:1];
    NSString *commandString = [@"ea740001" stringByAppendingString:value];
    [centralManager addTaskWithTaskID:mk_cq_taskConfigPIRSensorDelayOperation
                          commandData:commandString
                       characteristic:peripheral.cq_custom
                             sucBlock:sucBlock
                          failedBlock:failedBlock];
}

+ (void)cq_configDeviceTime:(id <MKCQDeviceTimeProtocol>)protocol
                   sucBlock:(void (^)(id returnData))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock {
    if (![self validTimeProtocol:protocol]) {
        [self operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *hexTime = [self getTimeString:protocol];
    if (!MKValidStr(hexTime)) {
        [self operationParamsErrorBlock:failedBlock];
        return;
    }
    NSString *commandString = [@"ea760006" stringByAppendingString:hexTime];
    [centralManager addTaskWithTaskID:mk_cq_taskConfigDeviceTimeOperation
                          commandData:commandString
                       characteristic:peripheral.cq_custom
                             sucBlock:sucBlock
                          failedBlock:failedBlock];
}

#pragma mark - Private method

+ (void)operationParamsErrorBlock:(void (^)(NSError *error))block {
    MKBLEBase_main_safe(^{
        if (block) {
            NSError *error = [MKBLEBaseSDKAdopter getErrorWithCode:-999 message:@"Params error"];
            block(error);
        }
    });
}

+ (void)operationSetParamsErrorBlock:(void (^)(NSError *error))block{
    MKBLEBase_main_safe(^{
        if (block) {
            NSError *error = [MKBLEBaseSDKAdopter getErrorWithCode:-10001 message:@"Set parameter error"];
            block(error);
        }
    });
}

+ (BOOL)validTimeProtocol:(id <MKCQDeviceTimeProtocol>)protocol{
    if (!protocol) {
        return NO;
    }
    if (protocol.year < 2000 || protocol.year > 2099) {
        return NO;
    }
    if (protocol.month < 1 || protocol.month > 12) {
        return NO;
    }
    if (protocol.day < 1 || protocol.day > 31) {
        return NO;
    }
    if (protocol.hour < 0 || protocol.hour > 23) {
        return NO;
    }
    if (protocol.minutes < 0 || protocol.minutes > 59) {
        return NO;
    }
    if (protocol.seconds < 0 || protocol.seconds > 59) {
        return NO;
    }
    return YES;
}

+ (NSString *)getTimeString:(id <MKCQDeviceTimeProtocol>)protocol{
    if (!protocol) {
        return @"";
    }
    
    unsigned long yearValue = protocol.year - 2000;
    NSString *yearString = [MKBLEBaseSDKAdopter fetchHexValue:yearValue byteLen:1];
    NSString *monthString = [MKBLEBaseSDKAdopter fetchHexValue:protocol.month byteLen:1];
    NSString *dayString = [MKBLEBaseSDKAdopter fetchHexValue:protocol.day byteLen:1];
    NSString *hourString = [MKBLEBaseSDKAdopter fetchHexValue:protocol.hour byteLen:1];
    NSString *minString = [MKBLEBaseSDKAdopter fetchHexValue:protocol.minutes byteLen:1];
    NSString *secString = [MKBLEBaseSDKAdopter fetchHexValue:protocol.seconds byteLen:1];
    return [NSString stringWithFormat:@"%@%@%@%@%@%@",yearString,monthString,dayString,hourString,minString,secString];
}

@end
