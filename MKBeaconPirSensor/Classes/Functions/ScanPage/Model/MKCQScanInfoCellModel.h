//
//  MKCQScanInfoCellModel.h
//  MKBeaconPirSensor_Example
//
//  Created by aa on 2021/8/17.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CBPeripheral;
@interface MKCQScanInfoCellModel : NSObject

@property (nonatomic, copy)NSString *rssi;

@property (nonatomic, copy)NSString *txPower;

@property (nonatomic, strong)CBPeripheral *peripheral;

@property (nonatomic, copy)NSString *deviceName;

@property (nonatomic, assign)BOOL pirStatus;

@property (nonatomic, copy)NSString *pirSensitivity;

@property (nonatomic, assign)BOOL hallStatus;

@property (nonatomic, copy)NSString *pirDelay;

@property (nonatomic, copy)NSString *macAddress;

@property (nonatomic, copy)NSString *timestamp;

@property (nonatomic, copy)NSString *voltage;

@property (nonatomic, copy)NSString *major;

@property (nonatomic, copy)NSString *minor;

@property (nonatomic, copy)NSString *rssi1M;

@property (nonatomic, assign)BOOL connectable;

@end

NS_ASSUME_NONNULL_END
