//
//  MKCQSyncTimeCell.m
//  MKBeaconPirSensor_Example
//
//  Created by aa on 2024/5/30.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import "MKCQSyncTimeCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"

#import "MKCustomUIAdopter.h"

@implementation MKCQSyncTimeCellModel
@end

@interface MKCQSyncTimeCell ()

@property (nonatomic, strong)UIView *backView;

@property (nonatomic, strong)UILabel *msgLabel;

@property (nonatomic, strong)UIButton *syncButton;

@property (nonatomic, strong)UILabel *dateLabel;

@property (nonatomic, strong)UILabel *timeLabel;

@end

@implementation MKCQSyncTimeCell

+ (MKCQSyncTimeCell *)initCellWithTableView:(UITableView *)tableView {
    MKCQSyncTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKCQSyncTimeCellIdenty"];
    if (!cell) {
        cell = [[MKCQSyncTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKCQSyncTimeCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = RGBCOLOR(242, 242, 242);
        [self.contentView addSubview:self.backView];
        
        [self.backView addSubview:self.msgLabel];
        [self.backView addSubview:self.syncButton];
        [self.backView addSubview:self.dateLabel];
        [self.backView addSubview:self.timeLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.backView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5.f);
        make.right.mas_equalTo(-5.f);
        make.top.mas_equalTo(5.f);
        make.bottom.mas_equalTo(-5.f);
    }];
    [self.syncButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10.f);
        make.width.mas_equalTo(50.f);
        make.top.mas_equalTo(5.f);
        make.height.mas_equalTo(30.f);
    }];
    [self.msgLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10.f);
        make.right.mas_equalTo(self.syncButton.mas_left).mas_offset(-5.f);
        make.centerY.mas_equalTo(self.syncButton.mas_centerY);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
    [self.dateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(self.backView.mas_centerX).mas_offset(-3.f);
        make.top.mas_equalTo(self.syncButton.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backView.mas_centerX).mas_offset(2.f);
        make.right.mas_equalTo(-15.f);
        make.centerY.mas_equalTo(self.dateLabel.mas_centerY);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
}

#pragma mark - event method
- (void)syncButtonPressed {
    if ([self.delegate respondsToSelector:@selector(cq_needUpdateDate)]) {
        [self.delegate cq_needUpdateDate];
    }
}

#pragma mark - setter
- (void)setDataModel:(MKCQSyncTimeCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel) {
        return;
    }
    self.dateLabel.text = SafeStr(_dataModel.date);
    self.timeLabel.text = SafeStr(_dataModel.time);
}

#pragma mark - getter
- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = COLOR_WHITE_MACROS;
        
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = 8.f;
    }
    return _backView;
}

- (UILabel *)msgLabel {
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.textColor = DEFAULT_TEXT_COLOR;
        _msgLabel.textAlignment = NSTextAlignmentLeft;
        _msgLabel.font = MKFont(15.f);
        _msgLabel.text = @"Sync Beacon time";
    }
    return _msgLabel;
}

- (UIButton *)syncButton {
    if (!_syncButton) {
        _syncButton = [MKCustomUIAdopter customButtonWithTitle:@"Sync"
                                                    titleColor:COLOR_WHITE_MACROS
                                               backgroundColor:NAVBAR_COLOR_MACROS
                                                        target:self
                                                        action:@selector(syncButtonPressed)];
    }
    return _syncButton;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.textColor = DEFAULT_TEXT_COLOR;
        _dateLabel.textAlignment = NSTextAlignmentLeft;
        _dateLabel.font = MKFont(13.f);
        _dateLabel.text = @"N/A";
    }
    return _dateLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = DEFAULT_TEXT_COLOR;
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.font = MKFont(13.f);
        _timeLabel.text = @"N/A";
    }
    return _timeLabel;
}

@end
