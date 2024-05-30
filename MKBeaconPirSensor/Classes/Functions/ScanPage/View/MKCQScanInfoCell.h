//
//  MKCQScanInfoCell.h
//  MKBeaconPirSensor_Example
//
//  Created by aa on 2024/5/29.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@class CBPeripheral;
@class MKCQScanInfoCellModel;
@protocol MKCQScanInfoCellDelegate <NSObject>

- (void)cq_scanInfoCell_connect:(CBPeripheral *)peripheral;

@end

@interface MKCQScanInfoCell : MKBaseCell

@property (nonatomic, weak)id <MKCQScanInfoCellDelegate>delegate;

@property (nonatomic, strong)MKCQScanInfoCellModel *dataModel;

+ (MKCQScanInfoCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
