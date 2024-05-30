//
//  MKCQInterface.m
//  MKBeaconPirSensor_Example
//
//  Created by aa on 2021/2/23.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKCQInterface.h"

#import "CBPeripheral+MKCQAdd.h"
#import "MKCQCentralManager.h"
#import "MKCQOperationID.h"

#define centralManager [MKCQCentralManager shared]
#define peripheral [MKCQCentralManager shared].peripheral

@implementation MKCQInterface

+ (void)cq_readModeIDWithSucBlock:(void (^)(id returnData))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_cq_taskReadModeIDOperation
                           characteristic:peripheral.cq_modeID
                                 sucBlock:sucBlock
                              failedBlock:failedBlock];
}

+ (void)cq_readSoftwareWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_cq_taskReadSoftwareOperation
                           characteristic:peripheral.cq_software
                                 sucBlock:sucBlock
                              failedBlock:failedBlock];
}

+ (void)cq_readFirmwareWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_cq_taskReadFirmwareOperation
                           characteristic:peripheral.cq_firmware
                                 sucBlock:sucBlock
                              failedBlock:failedBlock];
}

+ (void)cq_readHardwareWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_cq_taskReadHardwareOperation
                           characteristic:peripheral.cq_hardware
                                 sucBlock:sucBlock
                              failedBlock:failedBlock];
}

+ (void)cq_readProductionDateWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_cq_taskReadProductionDateOperation
                           characteristic:peripheral.cq_productionDate
                                 sucBlock:sucBlock
                              failedBlock:failedBlock];
}

+ (void)cq_readVendorWithSucBlock:(void (^)(id returnData))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_cq_taskReadVendorOperation
                           characteristic:peripheral.cq_vendor
                                 sucBlock:sucBlock
                              failedBlock:failedBlock];
}

+ (void)cq_readMajorWithSucBlock:(void (^)(id returnData))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_cq_taskReadMajorOperation
                           characteristic:peripheral.cq_major
                                 sucBlock:sucBlock
                              failedBlock:failedBlock];
}

+ (void)cq_readMinorWithSucBlock:(void (^)(id returnData))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_cq_taskReadMinorOperation
                           characteristic:peripheral.cq_minor
                                 sucBlock:sucBlock
                              failedBlock:failedBlock];
}

+ (void)cq_readRssiWithSucBlock:(void (^)(id returnData))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_cq_taskReadRssiOperation
                           characteristic:peripheral.cq_rssi
                                 sucBlock:sucBlock
                              failedBlock:failedBlock];
}

+ (void)cq_readTxPowerWithSucBlock:(void (^)(id returnData))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_cq_taskReadTxPowerOperation
                           characteristic:peripheral.cq_txPower
                                 sucBlock:sucBlock
                              failedBlock:failedBlock];
}

+ (void)cq_readAdvIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_cq_taskReadAdvIntervalOperation
                           characteristic:peripheral.cq_advInterval
                                 sucBlock:sucBlock
                              failedBlock:failedBlock];
}

+ (void)cq_readSerialIdWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_cq_taskReadSerialIdOperation
                           characteristic:peripheral.cq_serialId
                                 sucBlock:sucBlock
                              failedBlock:failedBlock];
}

+ (void)cq_readDeviceNameWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_cq_taskReadDeviceNameOperation
                           characteristic:peripheral.cq_deviceName
                                 sucBlock:sucBlock
                              failedBlock:failedBlock];
}

+ (void)cq_readMacAddresWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_cq_taskReadMacAddressOperation
                           characteristic:peripheral.cq_macAddress
                                 sucBlock:sucBlock
                              failedBlock:failedBlock];
}

+ (void)cq_readConnectEnableStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_cq_taskReadConnectableOperation
                           characteristic:peripheral.cq_connectable
                                 sucBlock:sucBlock
                              failedBlock:failedBlock];
}

+ (void)cq_readBatteryWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ea580000";
    [centralManager addTaskWithTaskID:mk_cq_taskReadBatteryOperation
                          commandData:commandString
                       characteristic:peripheral.cq_custom
                             sucBlock:sucBlock
                          failedBlock:failedBlock];
}

+ (void)cq_readRunningTimeWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ea590000";
    [centralManager addTaskWithTaskID:mk_cq_taskReadRunningTimeOperation
                          commandData:commandString
                       characteristic:peripheral.cq_custom
                             sucBlock:sucBlock
                          failedBlock:failedBlock];
}

+ (void)cq_readChipsetModelWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ea5b0000";
    [centralManager addTaskWithTaskID:mk_cq_taskReadChipsetModelOperation
                          commandData:commandString
                       characteristic:peripheral.cq_custom
                             sucBlock:sucBlock
                          failedBlock:failedBlock];
}

+ (void)cq_readButtonPowerStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ea710000";
    [centralManager addTaskWithTaskID:mk_cq_taskReadButtonPowerStatusOperation
                          commandData:commandString
                       characteristic:peripheral.cq_custom
                             sucBlock:sucBlock
                          failedBlock:failedBlock];
}

+ (void)cq_readPIRSensorSensitivityWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ea730000";
    [centralManager addTaskWithTaskID:mk_cq_taskReadPIRSensorSensitivityOperation
                          commandData:commandString
                       characteristic:peripheral.cq_custom
                             sucBlock:sucBlock
                          failedBlock:failedBlock];
}

+ (void)cq_readPIRSensorDelayWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ea750000";
    [centralManager addTaskWithTaskID:mk_cq_taskReadPIRSensorDelayOperation
                          commandData:commandString
                       characteristic:peripheral.cq_custom
                             sucBlock:sucBlock
                          failedBlock:failedBlock];
}

+ (void)cq_readDeviceTimeWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = @"ea770000";
    [centralManager addTaskWithTaskID:mk_cq_taskReadDeviceTimeOperation
                          commandData:commandString
                       characteristic:peripheral.cq_custom
                             sucBlock:sucBlock
                          failedBlock:failedBlock];
}

@end
