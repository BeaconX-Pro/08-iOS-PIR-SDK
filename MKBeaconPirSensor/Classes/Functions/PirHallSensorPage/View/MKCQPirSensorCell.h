//
//  MKCQPirSensorCell.h
//  MKBeaconPirSensor_Example
//
//  Created by aa on 2024/5/30.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCQPirSensorCellModel : NSObject

/// 0:Low 1:Medium 2:High
@property (nonatomic, assign)NSInteger sensitivity;

/// 0:Low 1:Medium 2:High
@property (nonatomic, assign)NSInteger delay;

@end

@protocol MKCQPirSensorCellDelegate <NSObject>

/// 用户选择了Sensitivity
/// - Parameter sensitivity: 0:Low 1:Medium 2:High
- (void)cq_pirSensorCell_sensitivityChanged:(NSInteger)sensitivity;

/// 用户选择了delay
/// - Parameter delay: 0:Low 1:Medium 2:High
- (void)cq_pirSensorCell_delayChanged:(NSInteger)delay;

@end

@interface MKCQPirSensorCell : MKBaseCell

@property (nonatomic, weak)id <MKCQPirSensorCellDelegate>delegate;

@property (nonatomic, strong)MKCQPirSensorCellModel *dataModel;

+ (MKCQPirSensorCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
