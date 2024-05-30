//
//  MKCQTaskAdopter.m
//  MKBeaconPirSensor_Example
//
//  Created by aa on 2021/2/22.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKCQTaskAdopter.h"

#import <CoreBluetooth/CoreBluetooth.h>

#import "MKBLEBaseSDKAdopter.h"
#import "MKBLEBaseSDKDefines.h"

#import "MKCQOperationID.h"
#import "MKCQAdopter.h"
#import "MKCQService.h"

@implementation MKCQTaskAdopter

+ (NSDictionary *)parseReadDataWithCharacteristic:(CBCharacteristic *)characteristic {
    NSData *readData = characteristic.value;
    if (!MKValidData(readData)) {
        return @{};
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_modeIDUUID]]){
        //产品型号信息
        return [self modeIDData:readData];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_productionDateUUID]]){
        //生产日期
        return [self productionDate:readData];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_firmwareUUID]]){
        //固件信息
        return [self firmwareData:readData];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_hardwareUUID]]){
        //硬件信息
        return [self hardwareData:readData];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_softwareUUID]]){
        //软件版本
        return [self softwareData:readData];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_vendorUUID]]){
        //厂商信息
        return [self vendorData:readData];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_majorUUID]]){
        //获取Major
        return [self majorData:readData];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_minorUUID]]){
        //获取Minor
        return [self minorData:readData];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_rssiUUID]]){
        //获取Rssi
        return [self rssiData:readData];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_txPowerUUID]]){
        //获取Tx Power
        return [self txPowerData:readData];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_passwordUUID]]){
        //密码
        return [self passwordData:readData];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_advIntervalUUID]]){
        return [self advIntervalData:readData];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_serialIdUUID]]){
        //获取Serial ID
        return [self serialId:readData];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_deviceNameUUID]]){
        //获取设备名称
        return [self deviceName:readData];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_macAddressUUID]]){
        //读取mac地址
        return [self macAddress:readData];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_connetableUUID]]) {
        //读取可连接状态
        return [self connectable:readData];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_customUUID]]){
        return [self customData:readData];
    }
    
    return @{};
}

+ (NSDictionary *)parseWriteDataWithCharacteristic:(CBCharacteristic *)characteristic {
    if (!characteristic) {
        return nil;
    }
    mk_cq_taskOperationID operationID = mk_cq_defaultTaskOperationID;
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_majorUUID]]){
        operationID = mk_cq_taskConfigMajorOperation;
    }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_minorUUID]]){
        operationID = mk_cq_taskConfigMinorOperation;
    }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_rssiUUID]]){
        operationID = mk_cq_taskConfigRssiOperation;
    }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_txPowerUUID]]){
        operationID = mk_cq_taskConfigTxPowerOperation;
    }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_advIntervalUUID]]){
        operationID = mk_cq_taskConfigAdvIntervalOperation;
    }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_serialIdUUID]]){
        operationID = mk_cq_taskConfigSerialIdOperation;
    }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_deviceNameUUID]]){
        operationID = mk_cq_taskConfigDeviceNameOperation;
    }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_connetableUUID]]) {
        operationID = mk_cq_taskConfigConnectableOperation;
    }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_resetUUID]]) {
        operationID = mk_cq_taskFactoryResetOperation;
    }
    return [self dataParserGetDataSuccess:@{@"success":@(YES)} operationID:operationID];
}

#pragma mark - private method

+ (NSDictionary *)modeIDData:(NSData *)data{
    NSString *tempString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *dic = @{@"modeID":tempString};
    return [self dataParserGetDataSuccess:dic operationID:mk_cq_taskReadModeIDOperation];
}

+ (NSDictionary *)productionDate:(NSData *)data{
    NSString *tempString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *dic = @{@"productionDate":tempString};
    return [self dataParserGetDataSuccess:dic operationID:mk_cq_taskReadProductionDateOperation];
}

+ (NSDictionary *)firmwareData:(NSData *)data{
    NSString *tempString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *dic = @{@"firmware":tempString};
    return [self dataParserGetDataSuccess:dic operationID:mk_cq_taskReadFirmwareOperation];
}

+ (NSDictionary *)hardwareData:(NSData *)data{
    NSString *tempString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *dic = @{@"hardware":tempString};
    return [self dataParserGetDataSuccess:dic operationID:mk_cq_taskReadHardwareOperation];
}

+ (NSDictionary *)softwareData:(NSData *)data{
    NSString *tempString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *dic = @{@"software":tempString};
    return [self dataParserGetDataSuccess:dic operationID:mk_cq_taskReadSoftwareOperation];
}

+ (NSDictionary *)vendorData:(NSData *)data{
    NSString *tempString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *dic = @{@"vendor":tempString};
    return [self dataParserGetDataSuccess:dic operationID:mk_cq_taskReadVendorOperation];
}

+ (NSDictionary *)majorData:(NSData *)data {
    NSString *content = [MKBLEBaseSDKAdopter hexStringFromData:data];
    if (content.length != 4) {
        return @{};
    }
    NSString *major = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
    return [self dataParserGetDataSuccess:@{@"major":major} operationID:mk_cq_taskReadMajorOperation];
}

+ (NSDictionary *)minorData:(NSData *)data {
    NSString *content = [MKBLEBaseSDKAdopter hexStringFromData:data];
    if (content.length != 4) {
        return @{};
    }
    NSString *minor = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
    return [self dataParserGetDataSuccess:@{@"minor":minor} operationID:mk_cq_taskReadMinorOperation];
}

+ (NSDictionary *)rssiData:(NSData *)data {
    NSString *content = [MKBLEBaseSDKAdopter hexStringFromData:data];
    if (content.length != 2) {
        return @{};
    }
    NSInteger rssi = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(0, content.length)];
    NSString *rssiValue = [NSString stringWithFormat:@"%ld",-1 * rssi];
    return [self dataParserGetDataSuccess:@{@"rssi":rssiValue} operationID:mk_cq_taskReadRssiOperation];
}

+ (NSDictionary *)txPowerData:(NSData *)data {
    NSString *content = [MKBLEBaseSDKAdopter hexStringFromData:data];
    if (content.length != 2) {
        return @{};
    }
    NSString *txPower = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
    return [self dataParserGetDataSuccess:@{@"txPower":txPower} operationID:mk_cq_taskReadTxPowerOperation];
}

+ (NSDictionary *)passwordData:(NSData *)data {
    NSString *content = [MKBLEBaseSDKAdopter hexStringFromData:data];
    if (content.length != 2) {
        return @{};
    }
    if ([content isEqualToString:@"00"]) {
        //解锁
        return [self dataParserGetDataSuccess:@{@"success":@(YES)} operationID:mk_cq_taskConfigPasswordOperation];
    }
    if ([content isEqualToString:@"02"]) {
        //修改密码
        return [self dataParserGetDataSuccess:@{@"success":@(YES)} operationID:mk_cq_taskChangePasswordOperation];
    }
    return @{};
}

+ (NSDictionary *)advIntervalData:(NSData *)data {
    NSString *content = [MKBLEBaseSDKAdopter hexStringFromData:data];
    if (content.length < 2) {
        return @{};
    }
    NSString *interval = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
    return [self dataParserGetDataSuccess:@{@"interval":interval} operationID:mk_cq_taskReadAdvIntervalOperation];
}

+ (NSDictionary *)serialId:(NSData *)data{
    NSString *tempString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *dic = @{@"serialId":(MKValidStr(tempString) ? tempString : @"")};
    return [self dataParserGetDataSuccess:dic operationID:mk_cq_taskReadSerialIdOperation];
}

+ (NSDictionary *)deviceName:(NSData *)data{
    NSString *tempString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSDictionary *dic = @{@"deviceName":(MKValidStr(tempString) ? tempString : @"")};
    return [self dataParserGetDataSuccess:dic operationID:mk_cq_taskReadDeviceNameOperation];
}

+ (NSDictionary *)macAddress:(NSData *)data{
    NSString *content = [MKBLEBaseSDKAdopter hexStringFromData:data];
    NSString *macAddress = [NSString stringWithFormat:@"%@:%@:%@:%@:%@:%@",[content substringWithRange:NSMakeRange(0, 2)],[content substringWithRange:NSMakeRange(2, 2)],[content substringWithRange:NSMakeRange(4, 2)],[content substringWithRange:NSMakeRange(6, 2)],[content substringWithRange:NSMakeRange(8, 2)],[content substringWithRange:NSMakeRange(10, 2)]];
    return [self dataParserGetDataSuccess:@{@"macAddress":[macAddress uppercaseString]} operationID:mk_cq_taskReadMacAddressOperation];
}

+ (NSDictionary *)connectable:(NSData *)data {
    NSString *content = [MKBLEBaseSDKAdopter hexStringFromData:data];
    if (content.length < 2) {
        return @{};
    }
    BOOL connectable = [content isEqualToString:@"00"];
    return [self dataParserGetDataSuccess:@{@"connectable":@(connectable)} operationID:mk_cq_taskReadConnectableOperation];
}

+ (NSDictionary *)customData:(NSData *)data{
    NSString *content = [MKBLEBaseSDKAdopter hexStringFromData:data];
    if (!MKValidStr(content) || content.length < 8) {
        return @{};
    }
    //配置信息，eb开头
    if (![[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"eb"]) {
        return @{};
    }
    NSInteger len = strtoul([[content substringWithRange:NSMakeRange(6, 2)] UTF8String],0,16);
    if (content.length != 2 * len + 8) {
        return @{};
    }
    NSString *function = [content substringWithRange:NSMakeRange(2, 2)];
    mk_cq_taskOperationID operationID = mk_cq_defaultTaskOperationID;
    NSDictionary *returnDic = nil;
    
    if ([function isEqualToString:@"58"]) {
        //读取电池电压
        NSString *valotage = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(8, len * 2)];
        operationID = mk_cq_taskReadBatteryOperation;
        returnDic = @{@"valotage":valotage};
    }else if ([function isEqualToString:@"59"]) {
        //读取运行总时间
        NSString *runningTime = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(8, len * 2)];
        operationID = mk_cq_taskReadRunningTimeOperation;
        returnDic = @{@"runningTime":runningTime};
    }else if ([function isEqualToString:@"5b"]) {
        //读取芯片类型
        NSString *model = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(4, len)] encoding:NSUTF8StringEncoding];
        operationID = mk_cq_taskReadChipsetModelOperation;
        returnDic = @{@"model":(MKValidStr(model) ? model : @"")};
    }else if ([function isEqualToString:@"6d"]) {
        //按键关机
        BOOL success = [[content substringWithRange:NSMakeRange(8, 2)] isEqualToString:@"aa"];
        operationID = mk_cq_taskConfigPowerOffOperation;
        returnDic = @{@"success":@(success)};
    }else if ([function isEqualToString:@"70"]) {
        //配置按键可关机状态
        BOOL success = [[content substringWithRange:NSMakeRange(8, 2)] isEqualToString:@"aa"];
        operationID = mk_cq_taskConfigButtonPowerStatusOperation;
        returnDic = @{@"success":@(success)};
    }else if ([function isEqualToString:@"71"]) {
        //读取按键可关机状态
        BOOL isOn = [[content substringWithRange:NSMakeRange(8, 2)] isEqualToString:@"01"];
        operationID = mk_cq_taskReadButtonPowerStatusOperation;
        returnDic = @{@"isOn":@(isOn)};
    }else if ([function isEqualToString:@"72"]) {
        //配置PIR灵敏度
        BOOL success = [[content substringWithRange:NSMakeRange(8, 2)] isEqualToString:@"aa"];
        operationID = mk_cq_taskConfigPIRSensorSensitivityOperation;
        returnDic = @{@"success":@(success)};
    }else if ([function isEqualToString:@"73"]) {
        //读取PIR灵敏度
        NSString *sensitivity = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(8, len * 2)];
        operationID = mk_cq_taskReadPIRSensorSensitivityOperation;
        returnDic = @{@"sensitivity":sensitivity};
    }else if ([function isEqualToString:@"74"]) {
        //配置PIR延时状态
        BOOL success = [[content substringWithRange:NSMakeRange(8, 2)] isEqualToString:@"aa"];
        operationID = mk_cq_taskConfigPIRSensorDelayOperation;
        returnDic = @{@"success":@(success)};
    }else if ([function isEqualToString:@"75"]) {
        //读取PIR延时状态
        NSString *delay = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(8, len * 2)];
        operationID = mk_cq_taskReadPIRSensorDelayOperation;
        returnDic = @{@"delay":delay};
    }else if ([function isEqualToString:@"76"]) {
        //配置设备当前时间
        BOOL success = [[content substringWithRange:NSMakeRange(8, 2)] isEqualToString:@"aa"];
        operationID = mk_cq_taskConfigDeviceTimeOperation;
        returnDic = @{@"success":@(success)};
    }else if ([function isEqualToString:@"77"]){
        //读取设备当前时间
        NSString *deviceTime = [MKCQAdopter deviceTime:[content substringWithRange:NSMakeRange(8, len * 2)]];
        operationID = mk_cq_taskReadDeviceTimeOperation;
        returnDic = @{@"deviceTime":deviceTime};
    }
    
    return [self dataParserGetDataSuccess:returnDic operationID:operationID];
}

#pragma mark - Private method
+ (NSDictionary *)dataParserGetDataSuccess:(NSDictionary *)returnData operationID:(mk_cq_taskOperationID)operationID{
    if (!returnData) {
        return nil;
    }
    return @{@"returnData":returnData,@"operationID":@(operationID)};
}

@end
