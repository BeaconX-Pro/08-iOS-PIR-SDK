//
//  MKCQCentralManager.h
//  MKBeaconPirSensor_Example
//
//  Created by aa on 2021/2/22.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MKBaseBleModule/MKBLEBaseDataProtocol.h>

#import "MKCQOperationID.h"

NS_ASSUME_NONNULL_BEGIN

@class CBCentralManager,CBPeripheral;
@class MKCQBaseBeacon;

//Notification of device connection status changes.
extern NSString *const mk_cq_peripheralConnectStateChangedNotification;

//Notification of changes in the status of the Bluetooth Center.
extern NSString *const mk_cq_centralManagerStateChangedNotification;

extern NSString *const mk_cq_pirHallSensorStatusChangedNotification;

typedef NS_ENUM(NSInteger, mk_cq_centralManagerStatus) {
    mk_cq_centralManagerStatusUnable,                           //不可用
    mk_cq_centralManagerStatusEnable,                           //可用状态
};

typedef NS_ENUM(NSInteger, mk_cq_centralConnectStatus) {
    mk_cq_centralConnectStatusUnknow,                                           //未知状态
    mk_cq_centralConnectStatusConnecting,                                       //正在连接
    mk_cq_centralConnectStatusConnected,                                        //连接成功
    mk_cq_centralConnectStatusConnectedFailed,                                  //连接失败
    mk_cq_centralConnectStatusDisconnect,
};

@protocol mk_cq_centralManagerScanDelegate <NSObject>

/// Scan to new device.
/// @param devicePara devicePara
- (void)mk_cq_receiveDevicePara:(NSDictionary *)devicePara;

@optional

/// Starts scanning equipment.
- (void)mk_cq_startScan;

/// Stops scanning equipment.
- (void)mk_cq_stopScan;

@end

@interface MKCQCentralManager : NSObject<MKBLEBaseCentralManagerProtocol>

@property (nonatomic, weak)id <mk_cq_centralManagerScanDelegate>delegate;

/// Current connection status
@property (nonatomic, assign, readonly)mk_cq_centralConnectStatus connectState;

+ (MKCQCentralManager *)shared;

/// Destroy the MKCQCentralManager singleton and the MKBLEBaseCentralManager singleton. After the dfu upgrade, you need to destroy these two and then reinitialize.
+ (void)sharedDealloc;

/// Destroy the MKCQCentralManager singleton and remove the manager list of MKBLEBaseCentralManager.
+ (void)removeFromCentralList;

- (nonnull CBCentralManager *)centralManager;

/// Currently connected devices
- (nullable CBPeripheral *)peripheral;

/// Current Bluetooth center status
- (mk_cq_centralManagerStatus )centralStatus;

/// Bluetooth Center starts scanning
- (void)startScan;

/// Bluetooth center stops scanning
- (void)stopScan;

/// Interface of connection
/// @param peripheral peripheral
/// @param password password,16 characters.
/// @param progressBlock progress callback
/// @param sucBlock succeed callback
/// @param failedBlock failed callback
- (void)connectPeripheral:(nonnull CBPeripheral *)peripheral
                 password:(nonnull NSString *)password
                 sucBlock:(void (^)(CBPeripheral *peripheral))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;

- (void)disconnect;

/**
 Add a design task (app - > peripheral) to the queue
 
 @param operationID operationID
 @param commandData Communication data
 @param characteristic characteristic
 @param sucBlock Communication succeed callback
 @param failedBlock Communication failed callback
 */
- (void)addTaskWithTaskID:(mk_cq_taskOperationID)operationID
              commandData:(NSString *)commandData
           characteristic:(CBCharacteristic *)characteristic
                 sucBlock:(void (^)(id returnData))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;
/**
 Add a reading task (app - > peripheral) to the queue
 
 @param operationID operationID
 @param characteristic characteristic
 @param sucBlock Communication succeed callback
 @param failedBlock Communication failed callback
 */
- (void)addReadTaskWithTaskID:(mk_cq_taskOperationID)operationID
               characteristic:(CBCharacteristic *)characteristic
                     sucBlock:(void (^)(id returnData))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock;

/**
 Whether to monitor sensor data

 @param notify BOOL
 @return result
 */
- (BOOL)notifySensorStatus:(BOOL)notify;

@end

NS_ASSUME_NONNULL_END
