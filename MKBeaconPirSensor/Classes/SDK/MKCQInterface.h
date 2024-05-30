//
//  MKCQInterface.h
//  MKBeaconPirSensor_Example
//
//  Created by aa on 2021/2/23.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCQInterface : NSObject
/**
 Reading the device's modeID
 
 @param sucBlock success callback
 @param failedBlock failed callback
 */
+ (void)cq_readModeIDWithSucBlock:(void (^)(id returnData))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;
/**
 Reading device’s software version
 
 @param sucBlock success callback
 @param failedBlock failed callback
 */
+ (void)cq_readSoftwareWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;
/**
 Reading device’s firmware version
 
 @param sucBlock success callback
 @param failedBlock failed callback
 */
+ (void)cq_readFirmwareWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;
/**
 Reading device’s hardware version
 
 @param sucBlock success callback
 @param failedBlock failed callback
 */
+ (void)cq_readHardwareWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;
/**
 Reading the production date of device
 
 @param sucBlock success callback
 @param failedBlock failed callback
 */
+ (void)cq_readProductionDateWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;
/**
 Reading the vendor information
 
 @param sucBlock success callback
 @param failedBlock failed callback
 */
+ (void)cq_readVendorWithSucBlock:(void (^)(id returnData))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Major.
/// @param sucBlock success callback
/// @param failedBlock failed callback
+ (void)cq_readMajorWithSucBlock:(void (^)(id returnData))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Minor.
/// @param sucBlock success callback
/// @param failedBlock failed callback
+ (void)cq_readMinorWithSucBlock:(void (^)(id returnData))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock;

/// RSSI.
/// @param sucBlock success callback
/// @param failedBlock failed callback
+ (void)cq_readRssiWithSucBlock:(void (^)(id returnData))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Tx Power.
/// @param sucBlock success callback
/// @param failedBlock failed callback
+ (void)cq_readTxPowerWithSucBlock:(void (^)(id returnData))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Adv Interval.
/// @param sucBlock success callback
/// @param failedBlock failed callback
+ (void)cq_readAdvIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/// Serial Id.
/// @param sucBlock success callback
/// @param failedBlock failed callback
+ (void)cq_readSerialIdWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Device Name.
/// @param sucBlock success callback
/// @param failedBlock failed callback
+ (void)cq_readDeviceNameWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/**
 Reading device’s MAC address
 
 @param sucBlock success callback
 @param failedBlock failed callback
 */
+ (void)cq_readMacAddresWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/**
 Reading current connection status
 
 @param sucBlock success callback
 @param failedBlock failed callback
 */
+ (void)cq_readConnectEnableStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/**
 Reading device’s battery power percentage
 
 @param sucBlock success callback
 @param failedBlock failed callback
 */
+ (void)cq_readBatteryWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/**
 Reading device’s running time.
 
 @param sucBlock success callback
 @param failedBlock failed callback
 */
+ (void)cq_readRunningTimeWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock;

/**
 Reading device’s Chipset model.
 
 @param sucBlock success callback
 @param failedBlock failed callback
 */
+ (void)cq_readChipsetModelWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Read whether the device can be shut down using the button.
/// @param sucBlock success callback
/// @param failedBlock failed callback
+ (void)cq_readButtonPowerStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock;

/// PIR Sensor Sensitivity.
/// @param sucBlock success callback
/// @param failedBlock failed callback
+ (void)cq_readPIRSensorSensitivityWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// PIR Sensor Delay.
/// @param sucBlock success callback
/// @param failedBlock failed callback
+ (void)cq_readPIRSensorDelayWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock;

/// Device time.
/// @param sucBlock success callback
/// @param failedBlock failed callback
+ (void)cq_readDeviceTimeWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
