//
//  MKCQPirHallSensorModel.h
//  MKBeaconPirSensor_Example
//
//  Created by aa on 2024/5/30.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCQPirHallSensorModel : NSObject

/// 0:Low 1:Medium 2:High
@property (nonatomic, assign)NSInteger sensitivity;

/// 0:Low 1:Medium 2:High
@property (nonatomic, assign)NSInteger delay;

/// YYYY/MM/DD
@property (nonatomic, copy)NSString *date;

/// HH:MM:SS
@property (nonatomic, copy)NSString *time;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)syncDateWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
