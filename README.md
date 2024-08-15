# iOS SDK for PIR product in BeaconX Pro APP Kit Guide

* This SDK support the company's PIR products.

# Design instructions

* We divide the communications between SDK and devices into two stages: Scanning stage, Connection stage.For ease of understanding, let's take a look at the related classes and the relationships between them.

`MKCQCentralManager`：global manager, check system's bluetooth status, listen status changes, the most important is scan and connect to devices;

`MKCQInterface`: When the device is successfully connected, the device data can be read through the interface in `MKCQInterface`;

`MKCQInterface+MKCQConfig.h`: When the device is successfully connected, you can configure the device data through the interface in `MKCQInterface+MKCQConfig.h`;


## Scanning Stage

in this stage, `MKCQCentralManager ` will scan and analyze the advertisement data of PIR devices, `MKCQCentralManager ` will create a dictionary instance for every physical devices, developers can get all advertisement data by its property.


## Connection Stage

Developers can use the API `connectPeripheral:password:sucBlock:failedBlock` to connect the device. 


# Get Started

### Development environment:

* Xcode9+， due to the DFU and Zip Framework based on Swift4.0, so please use Xcode9 or high version to develop;
* iOS14, we limit the minimum iOS system version to 14.0；

### Import to Project

CocoaPods

SDK is available through [CocoaPods](https://cocoapods.org).To install it, simply add the following line to your Podfile, and then import ` <MKBeaconPirSensor/MKCQSDK.h>` ：

**pod 'MKBeaconPirSensor/SDK'**


* <font color=#FF0000 face="黑体">!!!on iOS 10 and above, Apple add authority control of bluetooth, you need add the string to "info.plist" file of your project: Privacy - Bluetooth Peripheral Usage Description - "your description". as the screenshot below.</font>

* <font color=#FF0000 face="黑体">!!! In iOS13 and above, Apple added permission restrictions on Bluetooth APi. You need to add a string to the project's info.plist file: Privacy-Bluetooth Always Usage Description-"Your usage description".</font>


## Start Developing

### Get sharedInstance of Manager

First of all, the developer should get the sharedInstance of Manager:

```
MKCQCentralManager *manager = [MKCQCentralManager shared];
```

#### 1.Start scanning task to find devices around you,please follow the steps below:

* 1.`manager.delegate = self;` //Set the scan delegate and complete the related delegate methods.
* 2.you can start the scanning task in this way:`[manager startScan];`    
* 3.at the sometime, you can stop the scanning task in this way:`[manager stopScan];`

#### 2.Connect to device

* 1.The connection method is as follows:

```
[[MKCQCentralManager shared] connectPeripheral:peripheral password:password sucBlock:^(CBPeripheral *peripheral) {
        //Success 
    } failedBlock:^(NSError *error) {
        //Failure
    }];
```

#### 3.Get State

Through the manager, you can get the current Bluetooth status of the mobile phone and the connection status of the device.

*  When the Bluetooth status of the mobile phone changes，<font color=#FF0000 face="黑体">`mk_cq_centralManagerStateChangedNotification`</font> will be posted.You can get status in this way:

```
[[MKCQCentralManager shared] centralStatus];
```

*  When the device connection status changes，<font color=#FF0000 face="黑体"> `mk_cq_peripheralConnectStateChangedNotification` </font> will be posted.You can get the status in this way:

```
[MKCQCentralManager shared].connectState;
```

#### 4.Monitor sensor data.

When the device is connected, the developer can monitor the sensor data of the device through the following steps:

*  1.Open data monitoring by the following method:

```
[[MKCQCentralManager shared] notifySensorStatus:YES];
```


*  2.Register for `mk_cq_pirHallSensorStatusChangedNotification` notifications to monitor device sensor data changes.


```

[[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveSensorStatus:)
                                                 name:mk_cq_pirHallSensorStatusChangedNotification
                                               object:nil];
```


```
#pragma mark - Notification
- (void)receiveSensorStatus:(NSNotification *)note {
    /*
        @{
                @"hall":@(YES),
                @"pir":@(NO),
            };
    */
    NSDictionary *dataDic = note.userInfo;
}
```


# Change log

* 2024081501 first version;
