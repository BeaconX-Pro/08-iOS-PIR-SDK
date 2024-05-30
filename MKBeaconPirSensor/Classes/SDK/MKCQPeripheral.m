//
//  MKCQPeripheral.m
//  MKBeaconPirSensor_Example
//
//  Created by aa on 2021/2/22.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKCQPeripheral.h"

#import <CoreBluetooth/CoreBluetooth.h>

#import "CBPeripheral+MKCQAdd.h"
#import "MKCQService.h"

@interface MKCQPeripheral ()

@property (nonatomic, strong)CBPeripheral *peripheral;

@end

@implementation MKCQPeripheral

- (instancetype)initWithPeripheral:(CBPeripheral *)peripheral {
    if (self = [super init]) {
        self.peripheral = peripheral;
    }
    return self;
}

- (void)discoverServices {
    NSArray *services = @[[CBUUID UUIDWithString:cq_customServiceUUID],  //custom配置服务
                          [CBUUID UUIDWithString:cq_deviceServiceUUID]]; //设备信息服务
    [self.peripheral discoverServices:services];
}

- (void)discoverCharacteristics {
    for (CBService *service in self.peripheral.services) {
        if ([service.UUID isEqual:[CBUUID UUIDWithString:cq_customServiceUUID]]) {
            NSArray *characteristics = @[[CBUUID UUIDWithString:cq_majorUUID],
                                         [CBUUID UUIDWithString:cq_minorUUID],
                                         [CBUUID UUIDWithString:cq_rssiUUID],
                                         [CBUUID UUIDWithString:cq_txPowerUUID],
                                         [CBUUID UUIDWithString:cq_passwordUUID],
                                         [CBUUID UUIDWithString:cq_advIntervalUUID],
                                         [CBUUID UUIDWithString:cq_serialIdUUID],
                                         [CBUUID UUIDWithString:cq_deviceNameUUID],
                                         [CBUUID UUIDWithString:cq_macAddressUUID],
                                         [CBUUID UUIDWithString:cq_connetableUUID],
                                         [CBUUID UUIDWithString:cq_resetUUID],
                                         [CBUUID UUIDWithString:cq_sensorStatusUUID],
                                         [CBUUID UUIDWithString:cq_customUUID]];
            [self.peripheral discoverCharacteristics:characteristics forService:service];
        }else if ([service.UUID isEqual:[CBUUID UUIDWithString:cq_deviceServiceUUID]]) {
            NSArray *characteristics = @[[CBUUID UUIDWithString:cq_modeIDUUID],
                                         [CBUUID UUIDWithString:cq_firmwareUUID],
                                         [CBUUID UUIDWithString:cq_productionDateUUID],
                                         [CBUUID UUIDWithString:cq_hardwareUUID],
                                         [CBUUID UUIDWithString:cq_softwareUUID],
                                         [CBUUID UUIDWithString:cq_vendorUUID]];
            [self.peripheral discoverCharacteristics:characteristics forService:service];
        }
    }
}

- (void)updateCharacterWithService:(CBService *)service {
    [self.peripheral cq_updateCharacterWithService:service];
}

- (void)updateCurrentNotifySuccess:(CBCharacteristic *)characteristic {
    [self.peripheral cq_updateCurrentNotifySuccess:characteristic];
}

- (BOOL)connectSuccess {
    return [self.peripheral cq_connectSuccess];
}

- (void)setNil {
    [self.peripheral cq_setNil];
}

@end
