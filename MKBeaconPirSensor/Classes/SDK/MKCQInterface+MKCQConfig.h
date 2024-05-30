//
//  MKCQInterface+MKCQConfig.h
//  MKBeaconPirSensor_Example
//
//  Created by aa on 2021/2/23.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKCQInterface.h"

#import "MKCQCentralManager.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, mk_cq_slotRadioTxPower) {
    mk_cq_slotRadioTxPower4dBm,       //4dBm
    mk_cq_slotRadioTxPower0dBm,       //0dBm
    mk_cq_slotRadioTxPowerNeg4dBm,    //-4dBm
    mk_cq_slotRadioTxPowerNeg8dBm,    //-8dBm
    mk_cq_slotRadioTxPowerNeg12dBm,   //-12dBm
    mk_cq_slotRadioTxPowerNeg16dBm,   //-16dBm
    mk_cq_slotRadioTxPowerNeg20dBm,   //-20dBm
    mk_cq_slotRadioTxPowerNeg40dBm,   //-40dBm
};

typedef NS_ENUM(NSInteger, mk_cq_pirSensorDegree) {
    mk_cq_pirSensorDegree_low,
    mk_cq_pirSensorDegree_medium,
    mk_cq_pirSensorDegree_high,
};

@protocol MKCQDeviceTimeProtocol <NSObject>

@property (nonatomic, assign)NSInteger year;

@property (nonatomic, assign)NSInteger month;

@property (nonatomic, assign)NSInteger day;

@property (nonatomic, assign)NSInteger hour;

@property (nonatomic, assign)NSInteger minutes;

@property (nonatomic, assign)NSInteger seconds;

@end

@interface MKCQInterface (MKCQConfig)

/// Major.
/// @param major 0~65535
/// @param sucBlock success callback
/// @param failedBlock failed callback
+ (void)cq_configMajor:(NSInteger)major
              sucBlock:(void (^)(id returnData))sucBlock
           failedBlock:(void (^)(NSError *error))failedBlock;

/// Minor.
/// @param minor 0~65535
/// @param sucBlock success callback
/// @param failedBlock failed callback
+ (void)cq_configMinor:(NSInteger)minor
              sucBlock:(void (^)(id returnData))sucBlock
           failedBlock:(void (^)(NSError *error))failedBlock;

/// RSSI.
/// @param rssi -100dBm~0dBm
/// @param sucBlock success callback
/// @param failedBlock failed callback
+ (void)cq_configRssi:(NSInteger)rssi
             sucBlock:(void (^)(id returnData))sucBlock
          failedBlock:(void (^)(NSError *error))failedBlock;

/// Tx Power.
/// @param txPower txPower
/// @param sucBlock success callback
/// @param failedBlock failed callback
+ (void)cq_configTxPower:(mk_cq_slotRadioTxPower)txPower
                sucBlock:(void (^)(id returnData))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock;

/**
 Modifying connection password.
 
 @param password New password, 8 characters
 @param sucBlock success callback
 @param failedBlock failed callback
 */
+ (void)cq_modifyPassword:(NSString *)password
                 sucBlock:(void (^)(id returnData))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;

/// Adv Interval.
/// @param interval 1 x 100ms~100 x 100ms
/// @param sucBlock success callback
/// @param failedBlock failed callback
+ (void)cq_configAdvInterval:(NSInteger)interval
                    sucBlock:(void (^)(id returnData))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Serial Id.
/// @param serialId 1~5 number characters(0~99999).
/// @param sucBlock success callback
/// @param failedBlock failed callback
+ (void)cq_configSerialId:(NSString *)serialId
                 sucBlock:(void (^)(id returnData))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;

/// Device Name.
/// @param deviceName 1~10 characters.
/// @param sucBlock success callback
/// @param failedBlock failed callback
+ (void)cq_configDeviceName:(NSString *)deviceName
                   sucBlock:(void (^)(id returnData))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock;

/// Setting device’s connection status.
/// @param connectEnable YES：Connectable，NO：Not Connectable
/// @param sucBlock success callback
/// @param failedBlock failed callback
+ (void)cq_configConnectStatus:(BOOL)connectEnable
                       sucBlock:(void (^)(id returnData))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Resetting to factory state (RESET).NOTE:When resetting the device, the connection password will not be restored which shall remain set to its current value.
/// @param password connection password.
/// @param sucBlock success callback
/// @param failedBlock failed callback
+ (void)cq_factoryDataResetWithPassword:(NSString *)password
                               sucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/**
 Setting device power off

 @param sucBlock success callback
 @param failedBlock failed callback
 */
+ (void)cq_configPowerOffWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Setting whether the device can be shut down using the button.
/// @param isOn isOn
/// @param sucBlock success callback
/// @param failedBlock failed callback
+ (void)cq_configButtonPowerStatus:(BOOL)isOn
                           sucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// PIR Sensor Sensitivity.
/// @param sensitivity sensitivity
/// @param sucBlock success callback
/// @param failedBlock failed callback
+ (void)cq_configPIRSensorSensitivity:(mk_cq_pirSensorDegree)sensitivity
                             sucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// PIR Sensor Delay.
/// @param sensitivity sensitivity
/// @param sucBlock success callback
/// @param failedBlock failed callback
+ (void)cq_configPIRSensorDelay:(mk_cq_pirSensorDegree)delay
                       sucBlock:(void (^)(id returnData))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock;

/// 配置设备时间
/// @param protocol protocol
/// @param sucBlock success callback
/// @param failedBlock failed callback
+ (void)cq_configDeviceTime:(id <MKCQDeviceTimeProtocol>)protocol
                   sucBlock:(void (^)(id returnData))sucBlock
                failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
