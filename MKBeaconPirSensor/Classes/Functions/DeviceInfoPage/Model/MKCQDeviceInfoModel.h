//
//  MKCQDeviceInfoModel.h
//  MKBeaconPirSensor_Example
//
//  Created by aa on 2024/5/29.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCQDeviceInfoModel : NSObject

/**
 电池电量
 */
@property (nonatomic, copy)NSString *battery;

/**
 mac地址
 */
@property (nonatomic, copy)NSString *macAddress;

/**
 产品型号
 */
@property (nonatomic, copy)NSString *produce;

/**
 软件版本
 */
@property (nonatomic, copy)NSString *software;

/**
 固件版本
 */
@property (nonatomic, copy)NSString *firmware;

/**
 硬件版本
 */
@property (nonatomic, copy)NSString *hardware;

/**
 生产日期
 */
@property (nonatomic, copy)NSString *manuDate;

/**
 厂商信息
 */
@property (nonatomic, copy)NSString *manu;

@property (nonatomic, copy)NSString *runningTime;

@property (nonatomic, copy)NSString *chipsetModel;

- (void)readWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
