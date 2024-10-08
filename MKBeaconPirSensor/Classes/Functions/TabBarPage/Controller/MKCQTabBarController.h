//
//  MKCQTabBarController.h
//  MKBeaconPirSensor_Example
//
//  Created by aa on 2024/5/29.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKCQTabBarControllerDelegate <NSObject>

/// 返回到扫描页面，肯定需要开启扫描，当dfu升级之后返回扫描页面，则需要重新设置扫描代理
/// @param need YES:DFU升级情况下返回，需要设置扫描代理,NO:不需要重设代理
- (void)mk_cq_needResetScanDelegate:(BOOL)need;

@end

@interface MKCQTabBarController : UITabBarController

@property (nonatomic, weak)id <MKCQTabBarControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
