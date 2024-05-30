//
//  MKCQScanFilterView.h
//  MKBeaconPirSensor_Example
//
//  Created by aa on 2024/5/29.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCQScanFilterView : UIView

/// 加载扫描过滤页面
/// @param name 过滤的名字
/// @param macAddress    过滤的macAddress
/// @param rssi 过滤的rssi
/// @param searchBlock 回调
+ (void)showSearchName:(NSString *)name
            macAddress:(NSString *)macAddress
                  rssi:(NSInteger)rssi
           searchBlock:(void (^)(NSString *searchName, NSString *macAddress,NSInteger searchRssi))searchBlock;

@end

NS_ASSUME_NONNULL_END
