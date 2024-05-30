//
//  CBPeripheral+MKCQAdd.m
//  MKBeaconPirSensor_Example
//
//  Created by aa on 2021/2/22.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "CBPeripheral+MKCQAdd.h"

#import <objc/runtime.h>

#import "MKCQService.h"

static const char *cq_majorKey = "cq_majorKey";
static const char *cq_minorKey = "cq_minorKey";
static const char *cq_rssiKey = "cq_rssiKey";
static const char *cq_txPowerKey = "cq_txPowerKey";
static const char *cq_passwordKey = "cq_passwordKey";
static const char *cq_advIntervalKey = "cq_advIntervalKey";
static const char *cq_serialIdKey = "cq_serialIdKey";
static const char *cq_deviceNameKey = "cq_deviceNameKey";
static const char *cq_macAddressKey = "cq_macAddressKey";
static const char *cq_connectableKey = "cq_connectableKey";
static const char *cq_resetKey = "cq_resetKey";
static const char *cq_sensorStatusKey = "cq_sensorStatusKey";

static const char *cq_customKey = "cq_customKey";

static const char *cq_vendor = "cq_vendor";
static const char *cq_modeID = "cq_modeID";
static const char *cq_hardware = "cq_hardware";
static const char *cq_firmware = "cq_firmware";
static const char *cq_software = "cq_software";
static const char *cq_productionDate = "cq_productionDate";

static const char *cq_passwordNotifySuccessKey = "cq_passwordNotifySuccessKey";
static const char *cq_customNotifySuccessKey = "cq_customNotifySuccessKey";

@implementation CBPeripheral (MKCQAdd)

- (void)cq_updateCharacterWithService:(CBService *)service {
    if ([service.UUID isEqual:[CBUUID UUIDWithString:cq_customServiceUUID]]){
        //自定义配置服务
        [self cq_updateCustomCharacteristic:service];
        return;
    }
    if ([service.UUID isEqual:[CBUUID UUIDWithString:cq_deviceServiceUUID]]){
        //系统信息(软件版本、硬件版本等)
        [self cq_updateDeviceInfoCharacteristic:service];
        return;
    }
}

- (void)cq_updateCurrentNotifySuccess:(CBCharacteristic *)characteristic {
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_passwordUUID]]){
        objc_setAssociatedObject(self, &cq_passwordNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_customUUID]]){
        objc_setAssociatedObject(self, &cq_customNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
}

- (BOOL)cq_connectSuccess {
    if (![objc_getAssociatedObject(self, &cq_customNotifySuccessKey) boolValue] || ![objc_getAssociatedObject(self, &cq_passwordNotifySuccessKey) boolValue]) {
        return NO;
    }
    if (![self cq_deviceInfoServiceSuccess] || ![self cq_customServiceSuccess]) {
        return NO;
    }
    return YES;
}

- (void)cq_setNil {
    objc_setAssociatedObject(self, &cq_customKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &cq_majorKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &cq_minorKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &cq_rssiKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &cq_txPowerKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &cq_passwordKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &cq_advIntervalKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &cq_serialIdKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &cq_deviceNameKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &cq_macAddressKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &cq_connectableKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &cq_resetKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &cq_sensorStatusKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, &cq_vendor, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &cq_modeID, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &cq_hardware, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &cq_firmware, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &cq_software, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &cq_productionDate, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, &cq_customNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &cq_passwordNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - getter

- (CBCharacteristic *)cq_major {
    return objc_getAssociatedObject(self, &cq_majorKey);
}

- (CBCharacteristic *)cq_minor {
    return objc_getAssociatedObject(self, &cq_minorKey);
}

- (CBCharacteristic *)cq_rssi {
    return objc_getAssociatedObject(self, &cq_rssiKey);
}

- (CBCharacteristic *)cq_txPower {
    return objc_getAssociatedObject(self, &cq_txPowerKey);
}

- (CBCharacteristic *)cq_password{
    return objc_getAssociatedObject(self, &cq_passwordKey);
}

- (CBCharacteristic *)cq_advInterval {
    return objc_getAssociatedObject(self, &cq_advIntervalKey);
}

- (CBCharacteristic *)cq_serialId {
    return objc_getAssociatedObject(self, &cq_serialIdKey);
}

- (CBCharacteristic *)cq_deviceName {
    return objc_getAssociatedObject(self, &cq_deviceNameKey);
}

- (CBCharacteristic *)cq_macAddress {
    return objc_getAssociatedObject(self, &cq_macAddressKey);
}

- (CBCharacteristic *)cq_connectable {
    return objc_getAssociatedObject(self, &cq_connectableKey);
}

- (CBCharacteristic *)cq_reset {
    return objc_getAssociatedObject(self, &cq_resetKey);
}

- (CBCharacteristic *)cq_sensorStatus {
    return objc_getAssociatedObject(self, &cq_sensorStatusKey);
}

- (CBCharacteristic *)cq_custom{
    return objc_getAssociatedObject(self, &cq_customKey);
}

- (CBCharacteristic *)cq_modeID{
    return objc_getAssociatedObject(self, &cq_modeID);
}

- (CBCharacteristic *)cq_firmware{
    return objc_getAssociatedObject(self, &cq_firmware);
}

- (CBCharacteristic *)cq_productionDate{
    return objc_getAssociatedObject(self, &cq_productionDate);
}

- (CBCharacteristic *)cq_hardware{
    return objc_getAssociatedObject(self, &cq_hardware);
}

- (CBCharacteristic *)cq_software{
    return objc_getAssociatedObject(self, &cq_software);
}

- (CBCharacteristic *)cq_vendor{
    return objc_getAssociatedObject(self, &cq_vendor);
}

#pragma mark - private method

- (void)cq_updateCustomCharacteristic:(CBService *)service{
    if (!service) {
        return;
    }
    NSArray *charactList = [service.characteristics mutableCopy];
    for (CBCharacteristic *characteristic in charactList) {
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_customUUID]]){
            objc_setAssociatedObject(self, &cq_customKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            [self setNotifyValue:YES forCharacteristic:characteristic];
        }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_majorUUID]]) {
            objc_setAssociatedObject(self, &cq_majorKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_minorUUID]]) {
            objc_setAssociatedObject(self, &cq_minorKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_rssiUUID]]) {
            objc_setAssociatedObject(self, &cq_rssiKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_txPowerUUID]]) {
            objc_setAssociatedObject(self, &cq_txPowerKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            [self setNotifyValue:YES forCharacteristic:characteristic];
        }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_passwordUUID]]) {
            objc_setAssociatedObject(self, &cq_passwordKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            [self setNotifyValue:YES forCharacteristic:characteristic];
        }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_advIntervalUUID]]) {
            objc_setAssociatedObject(self, &cq_advIntervalKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_serialIdUUID]]) {
            objc_setAssociatedObject(self, &cq_serialIdKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_deviceNameUUID]]) {
            objc_setAssociatedObject(self, &cq_deviceNameKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_macAddressUUID]]) {
            objc_setAssociatedObject(self, &cq_macAddressKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_connetableUUID]]) {
            objc_setAssociatedObject(self, &cq_connectableKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_resetUUID]]) {
            objc_setAssociatedObject(self, &cq_resetKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_sensorStatusUUID]]) {
            objc_setAssociatedObject(self, &cq_sensorStatusKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
}

- (void)cq_updateDeviceInfoCharacteristic:(CBService *)service{
    if (!service) {
        return;
    }
    NSArray *charactList = [service.characteristics mutableCopy];
    for (CBCharacteristic *characteristic in charactList) {
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_modeIDUUID]]){
            //产品型号
            objc_setAssociatedObject(self, &cq_modeID, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_firmwareUUID]]){
            //固件版本
            objc_setAssociatedObject(self, &cq_firmware, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_productionDateUUID]]){
            //生产日期
            objc_setAssociatedObject(self, &cq_productionDate, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_hardwareUUID]]){
            //硬件版本
            objc_setAssociatedObject(self, &cq_hardware, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_softwareUUID]]){
            //软件版本
            objc_setAssociatedObject(self, &cq_software, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_vendorUUID]]){
            //厂商自定义
            objc_setAssociatedObject(self, &cq_vendor, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
}

- (BOOL)cq_customServiceSuccess{
    if (!self.cq_custom || !self.cq_major || !self.cq_minor || !self.cq_rssi || !self.cq_txPower || !self.cq_password || !self.cq_advInterval || !self.cq_serialId || !self.cq_deviceName || !self.cq_macAddress || !self.cq_connectable || !self.cq_reset || !self.cq_sensorStatus) {
        return NO;
    }
    return YES;
}

- (BOOL)cq_deviceInfoServiceSuccess{
    if (!self.cq_vendor || !self.cq_modeID || !self.cq_hardware || !self.cq_firmware || !self.cq_software
        || !self.cq_productionDate) {
        return NO;
    }
    return YES;
}

@end
