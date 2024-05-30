//
//  Target_BeaconPir_Module.m
//  MKBeaconPirSensor_Example
//
//  Created by aa on 2021/3/14.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "Target_BeaconPir_Module.h"

#import "MKCQScanViewController.h"

@implementation Target_BeaconPir_Module

- (UIViewController *)Action_BeaconPir_Module_ScanController:(NSDictionary *)params {
    return [[MKCQScanViewController alloc] init];
}

@end
