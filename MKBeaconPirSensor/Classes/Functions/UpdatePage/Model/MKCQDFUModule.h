//
//  MKCQDFUModule.h
//  MKBeaconPirSensor_Example
//
//  Created by aa on 2024/5/29.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCQDFUModule : NSObject

- (void)updateWithFileUrl:(NSString *)url
            progressBlock:(void (^)(CGFloat progress))progressBlock
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
