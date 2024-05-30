//
//  MKCQAdvParaCell.h
//  MKBeaconPirSensor_Example
//
//  Created by aa on 2024/5/28.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCQAdvParaCellModel : NSObject

@property (nonatomic, copy)NSString *advInterval;

@property (nonatomic, assign)NSInteger rssi1m;

@property (nonatomic, assign)NSInteger txPower;

@end

@protocol MKCQAdvParaCellDelegate <NSObject>

- (void)cq_advParaCell_intervalChanged:(NSString *)interval;

- (void)cq_advParaCell_rssiChanged:(NSInteger)rssi;

- (void)cq_advParaCell_txPowerChanged:(NSInteger)txPower;

@end

@interface MKCQAdvParaCell : MKBaseCell

@property (nonatomic, weak)id <MKCQAdvParaCellDelegate>delegate;

@property (nonatomic, strong)MKCQAdvParaCellModel *dataModel;

+ (MKCQAdvParaCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
