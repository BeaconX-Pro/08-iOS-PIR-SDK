//
//  MKCQCentralManager.m
//  MKBeaconPirSensor_Example
//
//  Created by aa on 2021/2/22.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKCQCentralManager.h"

#import "MKBLEBaseCentralManager.h"
#import "MKBLEBaseSDKDefines.h"
#import "MKBLEBaseSDKAdopter.h"
#import "MKBLEBaseLogManager.h"

#import "MKCQPeripheral.h"
#import "MKCQOperation.h"
#import "MKCQTaskAdopter.h"
#import "MKCQAdopter.h"
#import "CBPeripheral+MKCQAdd.h"
#import "MKCQService.h"

static NSString *const mk_cq_logName = @"mk_cq_bleLog";

NSString *const mk_cq_peripheralConnectStateChangedNotification = @"mk_cq_peripheralConnectStateChangedNotification";
NSString *const mk_cq_centralManagerStateChangedNotification = @"mk_cq_centralManagerStateChangedNotification";
NSString *const mk_cq_pirHallSensorStatusChangedNotification = @"mk_cq_pirHallSensorStatusChangedNotification";


static MKCQCentralManager *manager = nil;
static dispatch_once_t onceToken;

@interface MKCQCentralManager ()

@property (nonatomic, assign)mk_cq_centralConnectStatus connectState;

@property (nonatomic, copy)void (^sucBlock)(CBPeripheral *peripheral);

@property (nonatomic, copy)void (^failedBlock)(NSError *error);

@property (nonatomic, copy)NSString *password;

@end

@implementation MKCQCentralManager

- (instancetype)init {
    if (self = [super init]) {
        [[MKBLEBaseCentralManager shared] loadDataManager:self];
    }
    return self;
}

+ (MKCQCentralManager *)shared {
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [MKCQCentralManager new];
        }
    });
    return manager;
}

+ (void)sharedDealloc {
    [MKBLEBaseCentralManager singleDealloc];
    manager = nil;
    onceToken = 0;
}

+ (void)removeFromCentralList {
    [[MKBLEBaseCentralManager shared] removeDataManager:manager];
    manager = nil;
    onceToken = 0;
}

#pragma mark - MKBLEBaseScanProtocol
- (void)MKBLEBaseCentralManagerDiscoverPeripheral:(CBPeripheral *)peripheral
                                advertisementData:(NSDictionary<NSString *,id> *)advertisementData
                                             RSSI:(NSNumber *)RSSI {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSDictionary *dic = [self parseModelWithRssi:RSSI advDic:advertisementData peripheral:peripheral];
        if (!MKValidDict(dic)) {
            return;
        }
        if ([self.delegate respondsToSelector:@selector(mk_cq_receiveDevicePara:)]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate mk_cq_receiveDevicePara:dic];
            });
        }
    });
}

- (void)MKBLEBaseCentralManagerStartScan {
    if ([self.delegate respondsToSelector:@selector(mk_cq_startScan)]) {
        [self.delegate mk_cq_startScan];
    }
}

- (void)MKBLEBaseCentralManagerStopScan {
    if ([self.delegate respondsToSelector:@selector(mk_cq_stopScan)]) {
        [self.delegate mk_cq_stopScan];
    }
}

#pragma mark - MKBLEBaseCentralManagerStateProtocol
- (void)MKBLEBaseCentralManagerStateChanged:(MKCentralManagerState)centralManagerState {
    [[NSNotificationCenter defaultCenter] postNotificationName:mk_cq_centralManagerStateChangedNotification object:nil];
}

- (void)MKBLEBasePeripheralConnectStateChanged:(MKPeripheralConnectState)connectState {
    //连接成功的判断必须是发送密码成功之后
    if (connectState == MKPeripheralConnectStateUnknow) {
        self.connectState = mk_cq_centralConnectStatusUnknow;
    }else if (connectState == MKPeripheralConnectStateConnecting) {
        self.connectState = mk_cq_centralConnectStatusConnecting;
    }else if (connectState == MKPeripheralConnectStateDisconnect) {
        self.connectState = mk_cq_centralConnectStatusDisconnect;
    }else if (connectState == MKPeripheralConnectStateConnectedFailed) {
        self.connectState = mk_cq_centralConnectStatusConnectedFailed;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:mk_cq_peripheralConnectStateChangedNotification object:nil];
}

#pragma mark - MKBLEBaseCentralManagerProtocol
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (error) {
        NSLog(@"+++++++++++++++++接收数据出错");
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:cq_sensorStatusUUID]]) {
        //传感器状态
        NSString *content = [MKBLEBaseSDKAdopter hexStringFromData:characteristic.value];
        if (MKValidStr(content) && content.length == 4) {
            BOOL hall = [[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"];
            BOOL pir = [[content substringWithRange:NSMakeRange(2, 2)] isEqualToString:@"01"];
            NSDictionary *dic = @{
                @"hall":@(hall),
                @"pir":@(pir),
            };
            MKBLEBase_main_safe(^{
                [[NSNotificationCenter defaultCenter] postNotificationName:mk_cq_pirHallSensorStatusChangedNotification
                                                                    object:nil
                                                                  userInfo:dic];
            });
            return;
        }
        return;
    }
}
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    if (error) {
        NSLog(@"+++++++++++++++++发送数据出错");
        return;
    }
    
}

#pragma mark - public method
- (CBCentralManager *)centralManager {
    return [MKBLEBaseCentralManager shared].centralManager;
}

- (CBPeripheral *)peripheral {
    return [MKBLEBaseCentralManager shared].peripheral;
}

- (mk_cq_centralManagerStatus )centralStatus {
    return ([MKBLEBaseCentralManager shared].centralStatus == MKCentralManagerStateEnable)
    ? mk_cq_centralManagerStatusEnable
    : mk_cq_centralManagerStatusUnable;
}

- (void)startScan {
    [[MKBLEBaseCentralManager shared] scanForPeripheralsWithServices:@[]
                                                             options:@{CBCentralManagerScanOptionAllowDuplicatesKey:@(YES)}];
}

- (void)stopScan {
    [[MKBLEBaseCentralManager shared] stopScan];
}

- (void)connectPeripheral:(nonnull CBPeripheral *)peripheral
                 password:(nonnull NSString *)password
                 sucBlock:(void (^)(CBPeripheral *peripheral))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock {
    if (![MKBLEBaseSDKAdopter asciiString:password] || password.length != 8) {
        [self operationFailedBlockWithMsg:@"Password incorrect!" failedBlock:failedBlock];
        return;
    }
    self.password = nil;
    self.password = password;
    __weak typeof(self) weakSelf = self;
    [self connect:peripheral sucBlock:^(CBPeripheral * _Nonnull peripheral) {
        __strong typeof(self) sself = weakSelf;
        sself.sucBlock = nil;
        sself.failedBlock = nil;
        if (sucBlock) {
            sucBlock(peripheral);
        }
    } failedBlock:^(NSError * _Nonnull error) {
        __strong typeof(self) sself = weakSelf;
        sself.sucBlock = nil;
        sself.failedBlock = nil;
        if (failedBlock) {
            failedBlock(error);
        }
    }];
}

- (void)disconnect {
    [[MKBLEBaseCentralManager shared] disconnect];
}

- (void)addTaskWithTaskID:(mk_cq_taskOperationID)operationID
              commandData:(NSString *)commandData
           characteristic:(CBCharacteristic *)characteristic
                 sucBlock:(void (^)(id returnData))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock {
    MKCQOperation *operation = [self generateOperationWithOperationID:operationID
                                                           commandData:commandData
                                                        characteristic:characteristic
                                                              sucBlock:sucBlock
                                                           failedBlock:failedBlock];
    [[MKBLEBaseCentralManager shared] addOperation:operation];
}

- (void)addReadTaskWithTaskID:(mk_cq_taskOperationID)operationID
               characteristic:(CBCharacteristic *)characteristic
                     sucBlock:(void (^)(id returnData))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock {
    MKCQOperation *operation = [self generateReadOperationWithID:operationID
                                                   characteristic:characteristic
                                                         sucBlock:sucBlock
                                                      failedBlock:failedBlock];
    [[MKBLEBaseCentralManager shared] addOperation:operation];
}

- (BOOL)notifySensorStatus:(BOOL)notify {
    if (self.connectState != mk_cq_centralConnectStatusConnected || self.peripheral == nil || self.peripheral.cq_sensorStatus == nil) {
        return NO;
    }
    [self.peripheral setNotifyValue:notify forCharacteristic:self.peripheral.cq_sensorStatus];
    return YES;
}



- (void)connectDeviecSuccess {
    MKBLEBase_main_safe(^{
        self.connectState = mk_cq_centralConnectStatusConnected;
        [[NSNotificationCenter defaultCenter] postNotificationName:mk_cq_peripheralConnectStateChangedNotification
                                                            object:nil];
        
        if (self.sucBlock) {
            self.sucBlock([MKBLEBaseCentralManager shared].peripheral);
        }
    });
}



#pragma mark - communication method
- (MKCQOperation *)generateOperationWithOperationID:(mk_cq_taskOperationID)operationID
                                         commandData:(NSString *)commandData
                                      characteristic:(CBCharacteristic *)characteristic
                                            sucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock {
    if (![[MKBLEBaseCentralManager shared] readyToCommunication]) {
        [self operationFailedBlockWithMsg:@"The current connection device is in disconnect" failedBlock:failedBlock];
        return nil;
    }
    if (!MKValidStr(commandData)) {
        [self operationFailedBlockWithMsg:@"Input parameter error" failedBlock:failedBlock];
        return nil;
    }
    if (!characteristic) {
        [self operationFailedBlockWithMsg:@"Characteristic error" failedBlock:failedBlock];
        return nil;
    }
    __weak typeof(self) weakSelf = self;
    MKCQOperation *operation = [[MKCQOperation alloc] initOperationWithID:operationID commandBlock:^{
        [[MKBLEBaseCentralManager shared] sendDataToPeripheral:commandData characteristic:characteristic type:CBCharacteristicWriteWithResponse];
    } completeBlock:^(NSError *error, id returnData) {
        __strong typeof(self) sself = weakSelf;
        [sself parseTaskResult:error returnData:returnData sucBlock:sucBlock failedBlock:failedBlock];
    }];
    return operation;
}

- (MKCQOperation *)generateReadOperationWithID:(mk_cq_taskOperationID)operationID
                                 characteristic:(CBCharacteristic *)characteristic
                                       sucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    if (![[MKBLEBaseCentralManager shared] readyToCommunication]) {
        [self operationFailedBlockWithMsg:@"The current connection device is in disconnect" failedBlock:failedBlock];
        return nil;
    }
    if (!characteristic) {
        [self operationFailedBlockWithMsg:@"Characteristic error" failedBlock:failedBlock];
        return nil;
    }
    __weak typeof(self) weakSelf = self;
    MKCQOperation *operation = [[MKCQOperation alloc] initOperationWithID:operationID commandBlock:^{
        [[MKBLEBaseCentralManager shared].peripheral readValueForCharacteristic:characteristic];
    } completeBlock:^(NSError *error, id returnData) {
        __strong typeof(self) sself = weakSelf;
        [sself parseTaskResult:error returnData:returnData sucBlock:sucBlock failedBlock:failedBlock];
    }];
    return operation;
}

- (void)parseTaskResult:(NSError *)error
             returnData:(id)returnData
               sucBlock:(void (^)(id returnData))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock {
    if (error) {
        MKBLEBase_main_safe(^{
            if (failedBlock) {
                failedBlock(error);
            }
        });
        return ;
    }
    if (!returnData) {
        [self operationFailedBlockWithMsg:@"Request data error" failedBlock:failedBlock];
        return ;
    }
    NSDictionary *resultDic = @{@"msg":@"success",
                                @"code":@"1",
                                @"result":returnData,
                                };
    MKBLEBase_main_safe(^{
        if (sucBlock) {
            sucBlock(resultDic);
        }
    });
}

#pragma mark - private method
- (void)connect:(CBPeripheral *)peripheral
       sucBlock:(void (^)(CBPeripheral * _Nonnull peripheral))sucBlock
    failedBlock:(void (^)(NSError * _Nonnull error))failedBlock {
    self.sucBlock = nil;
    self.sucBlock = sucBlock;
    self.failedBlock = nil;
    self.failedBlock = failedBlock;
    MKCQPeripheral *bxpPeripheral = [[MKCQPeripheral alloc] initWithPeripheral:peripheral];
    [[MKBLEBaseCentralManager shared] connectDevice:bxpPeripheral sucBlock:^(CBPeripheral * _Nonnull peripheral) {
        [self sendPasswordToDevice];
    } failedBlock:failedBlock];
}

- (void)sendPasswordToDevice {
    NSString *commandData = @"";
    for (NSInteger i = 0; i < self.password.length; i ++) {
        int asciiCode = [self.password characterAtIndex:i];
        commandData = [commandData stringByAppendingString:[NSString stringWithFormat:@"%1lx",(unsigned long)asciiCode]];
    }
    __weak typeof(self) weakSelf = self;
    MKCQOperation *operation = [[MKCQOperation alloc] initOperationWithID:mk_cq_taskConfigPasswordOperation commandBlock:^{
        [[MKBLEBaseCentralManager shared] sendDataToPeripheral:commandData characteristic:[MKBLEBaseCentralManager shared].peripheral.cq_password type:CBCharacteristicWriteWithResponse];
    } completeBlock:^(NSError * _Nullable error, id  _Nullable returnData) {
        __strong typeof(self) sself = weakSelf;
        if (error || !MKValidDict(returnData) || ![returnData[@"success"] boolValue]) {
            //密码错误
            [sself operationFailedBlockWithMsg:@"Password Error" failedBlock:sself.failedBlock];
            return ;
        }
        //密码正确
        MKBLEBase_main_safe(^{
            sself.connectState = mk_cq_centralConnectStatusConnected;
            [[NSNotificationCenter defaultCenter] postNotificationName:mk_cq_peripheralConnectStateChangedNotification object:nil];
            if (sself.sucBlock) {
                sself.sucBlock([MKBLEBaseCentralManager shared].peripheral);
            }
        });
    }];
    [[MKBLEBaseCentralManager shared] addOperation:operation];
}

- (void)clearAllParams {
    self.sucBlock = nil;
    self.failedBlock = nil;
}

- (void)operationFailedBlockWithMsg:(NSString *)message failedBlock:(void (^)(NSError *error))failedBlock {
    NSError *error = [[NSError alloc] initWithDomain:@"com.moko.CQCentralManager"
                                                code:-999
                                            userInfo:@{@"errorInfo":message}];
    MKBLEBase_main_safe(^{
        if (failedBlock) {
            failedBlock(error);
        }
    });
}

- (NSDictionary *)parseModelWithRssi:(NSNumber *)rssi 
                              advDic:(NSDictionary *)advDic
                          peripheral:(CBPeripheral *)peripheral {
    NSData *manufacturerData = advDic[CBAdvertisementDataManufacturerDataKey];
    if ([rssi integerValue] == 127 || !MKValidData(manufacturerData) || manufacturerData.length != 25) {
        return @{};
    }
    NSData *manuId = [manufacturerData subdataWithRange:NSMakeRange(0, 2)];
    if (![[[MKBLEBaseSDKAdopter hexStringFromData:manuId] lowercaseString] isEqualToString:@"0a62"]) {
        return @{};
    }
    
    NSLog(@"%@",advDic);
    
    NSString *content = [MKBLEBaseSDKAdopter hexStringFromData:[manufacturerData subdataWithRange:NSMakeRange(4, 21)]];
    
    NSString *pirBinary = [MKBLEBaseSDKAdopter binaryByhex:[content substringWithRange:NSMakeRange(0, 2)]];
    
    BOOL pirStatus = [[pirBinary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
    NSString *pirSensitivity = @"0";
    if ([[pirBinary substringWithRange:NSMakeRange(5, 2)] isEqualToString:@"01"]) {
        pirSensitivity = @"1";
    }else if ([[pirBinary substringWithRange:NSMakeRange(5, 2)] isEqualToString:@"10"]) {
        pirSensitivity = @"2";
    }
    BOOL hallStatus = [[pirBinary substringWithRange:NSMakeRange(4, 1)] isEqualToString:@"1"];
    NSString *pirDelay = @"0";
    if ([[pirBinary substringWithRange:NSMakeRange(2, 2)] isEqualToString:@"01"]) {
        pirDelay = @"1";
    }else if ([[pirBinary substringWithRange:NSMakeRange(2, 2)] isEqualToString:@"10"]) {
        pirDelay = @"2";
    }
    
    NSString *tempMac = [[content substringWithRange:NSMakeRange(4, 12)] uppercaseString];
    NSString *macAddress = [NSString stringWithFormat:@"%@:%@:%@:%@:%@:%@",
    [tempMac substringWithRange:NSMakeRange(0, 2)],
    [tempMac substringWithRange:NSMakeRange(2, 2)],
    [tempMac substringWithRange:NSMakeRange(4, 2)],
    [tempMac substringWithRange:NSMakeRange(6, 2)],
    [tempMac substringWithRange:NSMakeRange(8, 2)],
    [tempMac substringWithRange:NSMakeRange(10, 2)]];
    
    NSInteger year = 2000 + [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(16, 2)];
    NSString *yearString = [NSString stringWithFormat:@"%ld",(long)year];
    NSInteger month = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(18, 2)];
    NSString *monthString = [NSString stringWithFormat:@"%ld",(long)month];
    if (monthString.length == 1) {
        monthString = [@"" stringByAppendingString:monthString];
    }
    NSInteger day = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(20, 2)];
    NSString *dayString = [NSString stringWithFormat:@"%ld",(long)day];
    if (dayString.length == 1) {
        dayString = [@"" stringByAppendingString:dayString];
    }
    NSInteger hour = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(22, 2)];
    NSString *hourString = [NSString stringWithFormat:@"%ld",(long)hour];
    if (hourString.length == 1) {
        hourString = [@"" stringByAppendingString:hourString];
    }
    NSInteger minute = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(24, 2)];
    NSString *minuteString = [NSString stringWithFormat:@"%ld",(long)minute];
    if (minuteString.length == 1) {
        minuteString = [@"" stringByAppendingString:minuteString];
    }
    NSInteger second = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(26, 2)];
    NSString *secondString = [NSString stringWithFormat:@"%ld",(long)second];
    if (secondString.length == 1) {
        secondString = [@"" stringByAppendingString:secondString];
    }
    
    NSString *timestamp = [NSString stringWithFormat:@"%@/%@/%@/%@:%@:%@",yearString,monthString,dayString,hourString,minuteString,secondString];
        
    NSString *voltage = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(28, 4)];
    NSString *major = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(32, 2)];
    NSString *minor = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(34, 2)];
    
    NSNumber *rssi1MValue = [MKBLEBaseSDKAdopter signedHexTurnString:[content substringWithRange:NSMakeRange(36, 2)]];
    NSString *rssi1M = [NSString stringWithFormat:@"%@",rssi1MValue];
        
    [self logToLocal:[@"扫描到设备:" stringByAppendingString:content]];
     
    
    return @{
        @"rssi":rssi,
        @"peripheral":peripheral,
        @"pirStatus":@(pirStatus),
        @"pirSensitivity":pirSensitivity,
        @"hallStatus":@(hallStatus),
        @"pirDelay":pirDelay,
        @"macAddress":macAddress,
        @"timestamp":timestamp,
        @"voltage":voltage,
        @"major":major,
        @"minor":minor,
        @"rssi1M":rssi1M,
        @"deviceName":(advDic[CBAdvertisementDataLocalNameKey] ? advDic[CBAdvertisementDataLocalNameKey] : @""),
        @"connectable":advDic[CBAdvertisementDataIsConnectable],
        @"txPower":(advDic[CBAdvertisementDataTxPowerLevelKey] ? advDic[CBAdvertisementDataTxPowerLevelKey] : @""),
    };
}

- (void)saveToLogData:(NSString *)string appToDevice:(BOOL)app {
    if (!MKValidStr(string)) {
        return;
    }
    NSString *fuction = (app ? @"App To Device" : @"Device To App");
    NSString *recordString = [NSString stringWithFormat:@"%@---->%@",fuction,string];
    [self logToLocal:recordString];
}

- (void)logToLocal:(NSString *)string {
    if (!MKValidStr(string)) {
        return;
    }
    [MKBLEBaseLogManager saveDataWithFileName:mk_cq_logName dataList:@[string]];
}

@end
