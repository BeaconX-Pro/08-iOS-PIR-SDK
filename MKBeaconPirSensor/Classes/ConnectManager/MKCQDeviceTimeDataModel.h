//
//  MKCQDeviceTimeDataModel.h
//  MKBeaconPirSensor_Example
//
//  Created by aa on 2024/5/30.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKCQInterface+MKCQConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKCQDeviceTimeDataModel : NSObject<MKCQDeviceTimeProtocol>

@property (nonatomic, assign)NSInteger year;

@property (nonatomic, assign)NSInteger month;

@property (nonatomic, assign)NSInteger day;

@property (nonatomic, assign)NSInteger hour;

@property (nonatomic, assign)NSInteger minutes;

@property (nonatomic, assign)NSInteger seconds;

@end

NS_ASSUME_NONNULL_END
