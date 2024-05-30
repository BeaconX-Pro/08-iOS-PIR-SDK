//
//  MKCQAdvContentCell.h
//  MKBeaconPirSensor_Example
//
//  Created by aa on 2024/5/28.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKCQAdvContentCellModel : NSObject

@property (nonatomic, copy)NSString *major;

@property (nonatomic, copy)NSString *minor;

@property (nonatomic, copy)NSString *deviceName;

@property (nonatomic, copy)NSString *serialId;

@end

@protocol MKCQAdvContentCellDelegate <NSObject>

/// 输入框内容发生改变
/// - Parameters:
///   - textId: 0:Major 1:Minor 2:Device Name 3:Serial ID
///   - value: 当前输入框内容
- (void)cq_advContentCell_textFieldValueChanged:(NSInteger)textId value:(NSString *)value;

@end

@interface MKCQAdvContentCell : MKBaseCell

@property (nonatomic, weak)id <MKCQAdvContentCellDelegate>delegate;

@property (nonatomic, strong)MKCQAdvContentCellModel *dataModel;

+ (MKCQAdvContentCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
