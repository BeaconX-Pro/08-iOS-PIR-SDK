//
//  CBPeripheral+MKCQAdd.h
//  MKBeaconPirSensor_Example
//
//  Created by aa on 2021/2/22.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

@interface CBPeripheral (MKCQAdd)

#pragma mark - 自定义服务下面的特征

@property (nonatomic, strong, readonly)CBCharacteristic *cq_major;
@property (nonatomic, strong, readonly)CBCharacteristic *cq_minor;
@property (nonatomic, strong, readonly)CBCharacteristic *cq_rssi;
@property (nonatomic, strong, readonly)CBCharacteristic *cq_txPower;
@property (nonatomic, strong, readonly)CBCharacteristic *cq_password;
@property (nonatomic, strong, readonly)CBCharacteristic *cq_advInterval;
@property (nonatomic, strong, readonly)CBCharacteristic *cq_serialId;
@property (nonatomic, strong, readonly)CBCharacteristic *cq_deviceName;
@property (nonatomic, strong, readonly)CBCharacteristic *cq_macAddress;
@property (nonatomic, strong, readonly)CBCharacteristic *cq_connectable;
@property (nonatomic, strong, readonly)CBCharacteristic *cq_reset;
@property (nonatomic, strong, readonly)CBCharacteristic *cq_sensorStatus;
@property (nonatomic, strong, readonly)CBCharacteristic *cq_custom;

#pragma mark - 系统信息下面的特征
/**
 Manufacturer,R
 */
@property (nonatomic, strong, readonly)CBCharacteristic *cq_vendor;

/**
 Product Model,R
 */
@property (nonatomic, strong, readonly)CBCharacteristic *cq_modeID;

/**
 Manufacture Date,R
 */
@property (nonatomic, strong, readonly)CBCharacteristic *cq_productionDate;

/**
 Hardware Version,R
 */
@property (nonatomic, strong, readonly)CBCharacteristic *cq_hardware;

/**
 Firmware Version,R
 */
@property (nonatomic, strong, readonly)CBCharacteristic *cq_firmware;

/**
 Software Version,R
 */
@property (nonatomic, strong, readonly)CBCharacteristic *cq_software;

- (void)cq_updateCharacterWithService:(CBService *)service;

- (void)cq_updateCurrentNotifySuccess:(CBCharacteristic *)characteristic;

- (BOOL)cq_connectSuccess;

- (void)cq_setNil;

@end

NS_ASSUME_NONNULL_END
