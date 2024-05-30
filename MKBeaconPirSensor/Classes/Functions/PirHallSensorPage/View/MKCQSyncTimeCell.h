//
//  MKCQSyncTimeCell.h
//  MKBeaconPirSensor_Example
//
//  Created by aa on 2024/5/30.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCQSyncTimeCellModel : NSObject

@property (nonatomic, copy)NSString *date;

@property (nonatomic, copy)NSString *time;

@end

@protocol MKCQSyncTimeCellDelegate <NSObject>

- (void)cq_needUpdateDate;

@end

@interface MKCQSyncTimeCell : MKBaseCell

@property (nonatomic, weak)id <MKCQSyncTimeCellDelegate>delegate;

@property (nonatomic, strong)MKCQSyncTimeCellModel *dataModel;

+ (MKCQSyncTimeCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
