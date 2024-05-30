//
//  MKCQPirHallSensorHeaderView.h
//  MKBeaconPirSensor_Example
//
//  Created by aa on 2024/5/30.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCQPirHallSensorHeaderView : UIView

- (void)updatePirStatus:(BOOL)pirStatus doorStatus:(BOOL)doorStatus;

@end

NS_ASSUME_NONNULL_END
