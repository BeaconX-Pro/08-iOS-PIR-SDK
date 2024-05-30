//
//  MKCQAdopter.m
//  MKBeaconPirSensor_Example
//
//  Created by aa on 2021/2/22.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKCQAdopter.h"

#import <CommonCrypto/CommonCryptor.h>

#import "MKBLEBaseSDKDefines.h"
#import "MKBLEBaseSDKAdopter.h"

@implementation MKCQAdopter

+ (BOOL)isRealNumber:(NSString *)number {
    NSString *regex =@"[0-9]*";
    NSPredicate *test = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [test evaluateWithObject:number];
}

+ (NSString *)deviceTime:(NSString *)content {
    NSString *year = [NSString stringWithFormat:@"%ld",(long)([MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(0, 2)] + 2000)];
    NSString *month = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)];
    if (month.length == 1) {
        month = [@"0" stringByAppendingString:month];
    }
    NSString *day = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 2)];
    if (day.length == 1) {
        day = [@"0" stringByAppendingString:day];
    }
    NSString *hour = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(6, 2)];
    if (hour.length == 1) {
        hour = [@"0" stringByAppendingString:hour];
    }
    NSString *minutes = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(8, 2)];
    if (minutes.length == 1) {
        minutes = [@"0" stringByAppendingString:minutes];
    }
    NSString *sec = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(10, 2)];
    if (sec.length == 1) {
        sec = [@"0" stringByAppendingString:sec];
    }
    return [NSString stringWithFormat:@"%@/%@/%@ %@:%@:%@",year,month,day,hour,minutes,sec];
}

@end
