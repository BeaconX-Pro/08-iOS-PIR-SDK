//
//  MKCQTabBarController.m
//  MKBeaconPirSensor_Example
//
//  Created by aa on 2024/5/29.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKCQTabBarController.h"

#import "MKMacroDefines.h"
#import "MKBaseNavigationController.h"

#import "MKAlertController.h"

#import "MKBLEBaseLogManager.h"

#import "MKCQAdvertisementController.h"
#import "MKCQSettingController.h"
#import "MKCQDeviceInfoController.h"

#import "MKCQCentralManager.h"

#import "MKCQConnectManager.h"

#import "MKCQDeviceInfoModel.h"

@implementation MKCQTabBarController

- (void)dealloc {
    NSLog(@"MKCQTabBarController销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (![[self.navigationController viewControllers] containsObject:self]){
        [[MKCQCentralManager shared] disconnect];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubPages];
    [self addNotifications];
}

#pragma mark - notes
- (void)gotoScanPage {
    @weakify(self);
    [self dismissViewControllerAnimated:YES completion:^{
        @strongify(self);
        if ([self.delegate respondsToSelector:@selector(mk_cq_needResetScanDelegate:)]) {
            [self.delegate mk_cq_needResetScanDelegate:NO];
        }
    }];
}

- (void)dfuUpdateComplete {
    @weakify(self);
    [self dismissViewControllerAnimated:YES completion:^{
        @strongify(self);
        if ([self.delegate respondsToSelector:@selector(mk_cq_needResetScanDelegate:)]) {
            [self.delegate mk_cq_needResetScanDelegate:YES];
        }
    }];
}

- (void)centralManagerStateChanged {
    if ([MKCQCentralManager shared].centralStatus != mk_cq_centralManagerStatusEnable) {
        [self showAlertWithMsg:@"The current system of bluetooth is not available!" title:@"Dismiss"];
    }
}

- (void)deviceConnectStateChanged {
    [self showAlertWithMsg:@"The device is disconnected." title:@"Dismiss"];
    return;
}

- (void)devicePowerOff {
    [self showAlertWithMsg:@"The device is turned off" title:@"Dismiss"];
}

#pragma mark - private method

- (void)addNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(gotoScanPage)
                                                 name:@"mk_cq_popToRootViewControllerNotification"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dfuUpdateComplete)
                                                 name:@"mk_cq_centralDeallocNotification"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceConnectStateChanged)
                                                 name:mk_cq_peripheralConnectStateChangedNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(centralManagerStateChanged)
                                                 name:mk_cq_centralManagerStateChangedNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(devicePowerOff)
                                                 name:@"mk_cq_powerOffNotification"
                                               object:nil];
}

- (void)showAlertWithMsg:(NSString *)msg title:(NSString *)title{
    MKAlertController *alertController = [MKAlertController alertControllerWithTitle:title
                                                                             message:msg
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    @weakify(self);
    UIAlertAction *moreAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        [self gotoScanPage];
    }];
    [alertController addAction:moreAction];
    
    //让setting页面推出的alert消失
    [[NSNotificationCenter defaultCenter] postNotificationName:@"mk_cq_needDismissAlert" object:nil];
    //让所有MKPickView消失
    [[NSNotificationCenter defaultCenter] postNotificationName:@"mk_customUIModule_dismissPickView" object:nil];
    [self performSelector:@selector(presentAlert:) withObject:alertController afterDelay:1.2f];
}

- (void)presentAlert:(UIAlertController *)alert {
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark -

- (void)loadSubPages {
    MKCQAdvertisementController *advPage = [[MKCQAdvertisementController alloc] init];
    advPage.tabBarItem.title = @"ADVERTISEMENT";
    advPage.tabBarItem.image = LOADICON(@"MKBeaconPirSensor", @"MKCQTabBarController", @"cq_slotTabBarItemUnselected.png");
    advPage.tabBarItem.selectedImage = LOADICON(@"MKBeaconPirSensor", @"MKCQTabBarController", @"cq_slotTabBarItemSelected.png");
    MKBaseNavigationController *advNav = [[MKBaseNavigationController alloc] initWithRootViewController:advPage];

    MKCQSettingController *settingPage = [[MKCQSettingController alloc] init];
    settingPage.tabBarItem.title = @"SETTING";
    settingPage.tabBarItem.image = LOADICON(@"MKBeaconPirSensor", @"MKCQTabBarController", @"cq_settingTabBarItemUnselected.png");
    settingPage.tabBarItem.selectedImage = LOADICON(@"MKBeaconPirSensor", @"MKCQTabBarController", @"cq_settingTabBarItemSelected.png");
    MKBaseNavigationController *settingNav = [[MKBaseNavigationController alloc] initWithRootViewController:settingPage];

    MKCQDeviceInfoController *devicePage = [[MKCQDeviceInfoController alloc] init];
    devicePage.tabBarItem.title = @"DEVICE";
    devicePage.tabBarItem.image = LOADICON(@"MKBeaconPirSensor", @"MKCQTabBarController", @"cq_deviceTabBarItemUnselected.png");
    devicePage.tabBarItem.selectedImage = LOADICON(@"MKBeaconPirSensor", @"MKCQTabBarController", @"cq_deviceTabBarItemSelected.png");
    MKBaseNavigationController *deviceNav = [[MKBaseNavigationController alloc] initWithRootViewController:devicePage];
    
    self.viewControllers = @[advNav,settingNav,deviceNav];
}

@end
