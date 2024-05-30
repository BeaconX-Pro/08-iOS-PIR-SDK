#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "CTMediator+MKCQAdd.h"
#import "MKCQConnectManager.h"
#import "MKCQDeviceTimeDataModel.h"
#import "MKCQAboutController.h"
#import "MKCQAdvertisementController.h"
#import "MKCQAdvertisementModel.h"
#import "MKCQAdvContentCell.h"
#import "MKCQAdvParaCell.h"
#import "MKCQDeviceInfoController.h"
#import "MKCQDeviceInfoModel.h"
#import "MKCQVPirHallSensorController.h"
#import "MKCQPirHallSensorModel.h"
#import "MKCQPirHallSensorHeaderView.h"
#import "MKCQPirSensorCell.h"
#import "MKCQSyncTimeCell.h"
#import "MKCQScanViewController.h"
#import "MKCQScanInfoCellModel.h"
#import "MKCQScanFilterView.h"
#import "MKCQScanInfoCell.h"
#import "MKCQScanSearchButton.h"
#import "MKCQSettingController.h"
#import "MKCQSettingModel.h"
#import "MKCQTabBarController.h"
#import "MKCQUpdateController.h"
#import "MKCQDFUModule.h"
#import "CBPeripheral+MKCQAdd.h"
#import "MKCQAdopter.h"
#import "MKCQCentralManager.h"
#import "MKCQInterface+MKCQConfig.h"
#import "MKCQInterface.h"
#import "MKCQOperation.h"
#import "MKCQOperationID.h"
#import "MKCQPeripheral.h"
#import "MKCQSDK.h"
#import "MKCQService.h"
#import "MKCQTaskAdopter.h"
#import "Target_BeaconPir_Module.h"

FOUNDATION_EXPORT double MKBeaconPirSensorVersionNumber;
FOUNDATION_EXPORT const unsigned char MKBeaconPirSensorVersionString[];

