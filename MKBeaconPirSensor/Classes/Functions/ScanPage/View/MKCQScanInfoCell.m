//
//  MKCQScanInfoCell.m
//  MKBeaconPirSensor_Example
//
//  Created by aa on 2024/5/29.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import "MKCQScanInfoCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"

#import "MKCustomUIAdopter.h"

#import "MKCQScanInfoCellModel.h"

static CGFloat const offset_X = 15.f;
static CGFloat const rssiIconWidth = 22.f;
static CGFloat const rssiIconHeight = 11.f;
static CGFloat const batteryIconWidth = 25.f;
static CGFloat const batteryIconHeight = 25.f;
static CGFloat const connectButtonWidth = 80.f;
static CGFloat const connectButtonHeight = 30.f;

@interface MKCQScanInfoCell ()

/**
 信号icon
 */
@property (nonatomic, strong)UIImageView *rssiIcon;

/**
 信号强度
 */
@property (nonatomic, strong)UILabel *rssiLabel;

/**
 设备名称
 */
@property (nonatomic, strong)UILabel *nameLabel;

/**
 连接按钮
 */
@property (nonatomic, strong)UIButton *connectButton;

/**
 电池图标
 */
@property (nonatomic, strong)UIImageView *batteryIcon;

@property (nonatomic, strong)UILabel *batteryLabel;

@property (nonatomic, strong)UILabel *txPowerLabel;

@property (nonatomic, strong)UILabel *macLabel;

@property (nonatomic, strong)UILabel *timeLabel;

@property (nonatomic, strong)UIView *topBackView;

@property (nonatomic, strong)UIView *centerBackView;

@property (nonatomic, strong)UIView *bottomBackView;



@property (nonatomic, strong)UIView *centerLine;

@property (nonatomic, strong)UILabel *pirLabel;

@property (nonatomic, strong)UIImageView *bluePoint;

@property (nonatomic, strong)UILabel *rssi1mLabel;

@property (nonatomic, strong)UILabel *rssi1mValueLabel;

@property (nonatomic, strong)UILabel *pirSatusLabel;

@property (nonatomic, strong)UILabel *pirSatusValueLabel;

@property (nonatomic, strong)UILabel *pirSensitivityLabel;

@property (nonatomic, strong)UILabel *pirSensitivityValueLabel;

@property (nonatomic, strong)UILabel *doorStatusLabel;

@property (nonatomic, strong)UILabel *doorStatusValueLabel;

@property (nonatomic, strong)UILabel *pirDelayLabel;

@property (nonatomic, strong)UILabel *pirDelayValueLabel;

@property (nonatomic, strong)UILabel *majorLabel;

@property (nonatomic, strong)UILabel *majorValueLabel;

@property (nonatomic, strong)UILabel *minorLabel;

@property (nonatomic, strong)UILabel *minorValueLabel;

@end

@implementation MKCQScanInfoCell

+ (MKCQScanInfoCell *)initCellWithTableView:(UITableView *)tableView{
    MKCQScanInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKCQScanInfoCellIdenty"];
    if (!cell) {
        cell = [[MKCQScanInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKCQScanInfoCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.topBackView];
        [self.contentView addSubview:self.centerBackView];
        [self.contentView addSubview:self.bottomBackView];
        
        [self.topBackView addSubview:self.rssiIcon];
        [self.topBackView addSubview:self.rssiLabel];
        [self.topBackView addSubview:self.nameLabel];
        [self.topBackView addSubview:self.connectButton];
        
        [self.centerBackView addSubview:self.batteryIcon];
        
        [self.bottomBackView addSubview:self.txPowerLabel];
        [self.bottomBackView addSubview:self.macLabel];
        [self.bottomBackView addSubview:self.batteryLabel];
        [self.bottomBackView addSubview:self.timeLabel];
        
        [self.contentView addSubview:self.centerLine];
        
        [self.contentView addSubview:self.bluePoint];
        [self.contentView addSubview:self.pirLabel];
        [self.contentView addSubview:self.rssi1mLabel];
        [self.contentView addSubview:self.rssi1mValueLabel];
        [self.contentView addSubview:self.pirSatusLabel];
        [self.contentView addSubview:self.pirSatusValueLabel];
        [self.contentView addSubview:self.pirSensitivityLabel];
        [self.contentView addSubview:self.pirSensitivityValueLabel];
        [self.contentView addSubview:self.doorStatusLabel];
        [self.contentView addSubview:self.doorStatusValueLabel];
        [self.contentView addSubview:self.pirDelayLabel];
        [self.contentView addSubview:self.pirDelayValueLabel];
        [self.contentView addSubview:self.majorLabel];
        [self.contentView addSubview:self.majorValueLabel];
        [self.contentView addSubview:self.minorLabel];
        [self.contentView addSubview:self.minorValueLabel];
        
        [self.layer setMasksToBounds:YES];
        [self.layer setCornerRadius:4.f];
    }
    return self;
}

#pragma mark - 父类方法
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.topBackView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(40.f);
    }];
    [self.rssiIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20.f);
        make.top.mas_equalTo(10.f);
        make.width.mas_equalTo(rssiIconWidth);
        make.height.mas_equalTo(rssiIconHeight);
    }];
    [self.rssiLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.rssiIcon.mas_centerX);
        make.width.mas_equalTo(40.f);
        make.top.mas_equalTo(self.rssiIcon.mas_bottom).mas_offset(5.f);
        make.height.mas_equalTo(MKFont(10.f).lineHeight);
    }];
    CGFloat nameWidth = (self.contentView.frame.size.width - 2 * offset_X - rssiIconWidth - 10.f - 8.f - connectButtonWidth);
    CGSize nameSize = [NSString sizeWithText:self.nameLabel.text
                                     andFont:self.nameLabel.font
                                  andMaxSize:CGSizeMake(nameWidth, MAXFLOAT)];
    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.rssiIcon.mas_right).mas_offset(20.f);
        make.centerY.mas_equalTo(self.rssiIcon.mas_centerY);
        make.right.mas_equalTo(self.connectButton.mas_left).mas_offset(-8.f);
        make.height.mas_equalTo(nameSize.height);
    }];
    [self.connectButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-offset_X);
        make.width.mas_equalTo(connectButtonWidth);
        make.centerY.mas_equalTo(self.topBackView.mas_centerY);
        make.height.mas_equalTo(connectButtonHeight);
    }];
    [self.centerBackView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.topBackView.mas_bottom);
        make.height.mas_equalTo(batteryIconHeight);
    }];
    [self.batteryIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(offset_X);
        make.width.mas_equalTo(batteryIconWidth);
        make.centerY.mas_equalTo(self.centerBackView.mas_centerY);
        make.height.mas_equalTo(batteryIconHeight);
    }];
    [self.macLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.right.mas_equalTo(self.timeLabel.mas_left).mas_offset(-5.f);
        make.bottom.mas_equalTo(self.batteryIcon.mas_centerY).mas_offset(2.f);
        make.height.mas_equalTo(MKFont(12.f).lineHeight);
    }];
    [self.txPowerLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.right.mas_equalTo(self.timeLabel.mas_left).mas_offset(-5.f);
        make.centerY.mas_equalTo(self.batteryLabel.mas_centerY).mas_offset(2.f);
        make.height.mas_equalTo(MKFont(12.f).lineHeight);
    }];
    [self.timeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(70.f);
        make.centerY.mas_equalTo(self.txPowerLabel.mas_centerY);
        make.height.mas_equalTo(MKFont(10.f).lineHeight);
    }];
    
    [self.bottomBackView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.centerBackView.mas_bottom);
        make.height.mas_equalTo(20.f);
    }];
    [self.batteryLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.batteryIcon.mas_centerX);
        make.width.mas_equalTo(45.f);
        make.top.mas_equalTo(3.f);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
    
    [self.centerLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(offset_X);
        make.right.mas_equalTo(-offset_X);
        make.top.mas_equalTo(self.bottomBackView.mas_bottom).mas_offset(5.f);
        make.height.mas_equalTo(CUTTING_LINE_HEIGHT);
    }];
    [self.bluePoint mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.rssiLabel.mas_centerX);
        make.width.mas_equalTo(7.f);
        make.top.mas_equalTo(self.centerLine.mas_bottom).mas_offset(5.f);
        make.height.mas_equalTo(7.f);
    }];
    
    [self.pirLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.right.mas_equalTo(-offset_X);
        make.centerY.mas_equalTo(self.bluePoint.mas_centerY);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.rssi1mLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.right.mas_equalTo(self.rssi1mValueLabel.mas_left).mas_offset(-10.f);
        make.top.mas_equalTo(self.bluePoint.mas_bottom).mas_offset(5.f);
        make.height.mas_equalTo(MKFont(11.f).lineHeight);
    }];
    [self.rssi1mValueLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(120.f);
        make.right.mas_equalTo(-offset_X);
        make.centerY.mas_equalTo(self.rssi1mLabel.mas_centerY);
        make.height.mas_equalTo(MKFont(11.f).lineHeight);
    }];
    [self.pirSatusLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.right.mas_equalTo(self.pirSatusValueLabel.mas_left).mas_offset(-10.f);
        make.top.mas_equalTo(self.rssi1mLabel.mas_bottom).mas_offset(5.f);
        make.height.mas_equalTo(MKFont(11.f).lineHeight);
    }];
    [self.pirSatusValueLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(120.f);
        make.right.mas_equalTo(-offset_X);
        make.centerY.mas_equalTo(self.pirSatusLabel.mas_centerY);
        make.height.mas_equalTo(MKFont(11.f).lineHeight);
    }];
    [self.pirSensitivityLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.right.mas_equalTo(self.pirSensitivityValueLabel.mas_left).mas_offset(-10.f);
        make.top.mas_equalTo(self.pirSatusLabel.mas_bottom).mas_offset(5.f);
        make.height.mas_equalTo(MKFont(11.f).lineHeight);
    }];
    [self.pirSensitivityValueLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(120.f);
        make.right.mas_equalTo(-offset_X);
        make.centerY.mas_equalTo(self.pirSensitivityLabel.mas_centerY);
        make.height.mas_equalTo(MKFont(11.f).lineHeight);
    }];
    [self.doorStatusLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.right.mas_equalTo(self.doorStatusValueLabel.mas_left).mas_offset(-10.f);
        make.top.mas_equalTo(self.pirSensitivityLabel.mas_bottom).mas_offset(5.f);
        make.height.mas_equalTo(MKFont(11.f).lineHeight);
    }];
    [self.doorStatusValueLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(120.f);
        make.right.mas_equalTo(-offset_X);
        make.centerY.mas_equalTo(self.doorStatusLabel.mas_centerY);
        make.height.mas_equalTo(MKFont(11.f).lineHeight);
    }];
    [self.pirDelayLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.right.mas_equalTo(self.pirDelayValueLabel.mas_left).mas_offset(-10.f);
        make.top.mas_equalTo(self.doorStatusLabel.mas_bottom).mas_offset(5.f);
        make.height.mas_equalTo(MKFont(11.f).lineHeight);
    }];
    [self.pirDelayValueLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(120.f);
        make.right.mas_equalTo(-offset_X);
        make.centerY.mas_equalTo(self.pirDelayLabel.mas_centerY);
        make.height.mas_equalTo(MKFont(11.f).lineHeight);
    }];
    [self.majorLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.right.mas_equalTo(self.majorValueLabel.mas_left).mas_offset(-10.f);
        make.top.mas_equalTo(self.pirDelayLabel.mas_bottom).mas_offset(5.f);
        make.height.mas_equalTo(MKFont(11.f).lineHeight);
    }];
    [self.majorValueLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(120.f);
        make.right.mas_equalTo(-offset_X);
        make.centerY.mas_equalTo(self.majorLabel.mas_centerY);
        make.height.mas_equalTo(MKFont(11.f).lineHeight);
    }];
    [self.minorLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_left);
        make.right.mas_equalTo(self.minorValueLabel.mas_left).mas_offset(-10.f);
        make.top.mas_equalTo(self.majorLabel.mas_bottom).mas_offset(5.f);
        make.height.mas_equalTo(MKFont(11.f).lineHeight);
    }];
    [self.minorValueLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(120.f);
        make.right.mas_equalTo(-offset_X);
        make.centerY.mas_equalTo(self.minorLabel.mas_centerY);
        make.height.mas_equalTo(MKFont(11.f).lineHeight);
    }];
}

#pragma mark - event method
- (void)connectButtonPressed {
    if ([self.delegate respondsToSelector:@selector(cq_scanInfoCell_connect:)]) {
        [self.delegate cq_scanInfoCell_connect:self.dataModel.peripheral];
    }
}

#pragma mark - setter
- (void)setDataModel:(MKCQScanInfoCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKCQScanInfoCellModel.class]) {
        return;
    }
    
    self.rssiLabel.text = [SafeStr(_dataModel.rssi) stringByAppendingString:@"dBm"];
    self.txPowerLabel.text = [NSString stringWithFormat:@"%@%@%@",@"Tx Power: ",_dataModel.txPower,@"dBm"];
    self.nameLabel.text = (ValidStr(_dataModel.deviceName) ? _dataModel.deviceName : @"N/A");
    self.macLabel.text = [NSString stringWithFormat:@"%@%@",@"MAC: ",_dataModel.macAddress];
    self.batteryLabel.text = [_dataModel.voltage stringByAppendingString:@"mV"];
    self.connectButton.hidden = !_dataModel.connectable;
    self.rssi1mValueLabel.text = [_dataModel.rssi1M stringByAppendingString:@"dBm"];
    self.pirSatusValueLabel.text = (_dataModel.pirStatus ? @"Motion detected" : @"No motion detected");
    self.pirSensitivityValueLabel.text = @"Low";
    if ([_dataModel.pirSensitivity integerValue] == 1) {
        self.pirSensitivityValueLabel.text = @"Medium";
    }else if ([_dataModel.pirSensitivity integerValue] == 2) {
        self.pirSensitivityValueLabel.text = @"High";
    }
    self.doorStatusValueLabel.text = (_dataModel.hallStatus ? @"Open" : @"Close");
    self.pirDelayValueLabel.text = @"Low";
    if ([_dataModel.pirDelay integerValue] == 1) {
        self.pirDelayValueLabel.text = @"Medium";
    }else if ([_dataModel.pirDelay integerValue] == 2) {
        self.pirDelayValueLabel.text = @"High";
    }
    self.majorValueLabel.text = SafeStr(_dataModel.major);
    self.minorValueLabel.text = SafeStr(_dataModel.minor);
}

#pragma mark - getter
- (UIImageView *)rssiIcon{
    if (!_rssiIcon) {
        _rssiIcon = [[UIImageView alloc] init];
        _rssiIcon.image = LOADICON(@"MKBeaconPirSensor", @"MKCQScanInfoCell", @"cq_scan_rssiIcon.png");
    }
    return _rssiIcon;
}

- (UILabel *)rssiLabel{
    if (!_rssiLabel) {
        _rssiLabel = [self createLabelWithFont:MKFont(10)];
        _rssiLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _rssiLabel;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [self createLabelWithFont:MKFont(15.f)];
        _nameLabel.textColor = DEFAULT_TEXT_COLOR;
        _nameLabel.numberOfLines = 0;
    }
    return _nameLabel;
}

- (UIButton *)connectButton{
    if (!_connectButton) {
        _connectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_connectButton setBackgroundColor:NAVBAR_COLOR_MACROS];
        [_connectButton setTitle:@"CONNECT" forState:UIControlStateNormal];
        [_connectButton setTitleColor:COLOR_WHITE_MACROS forState:UIControlStateNormal];
        [_connectButton.titleLabel setFont:MKFont(15.f)];
        [_connectButton.layer setMasksToBounds:YES];
        [_connectButton.layer setCornerRadius:10.f];
        [_connectButton addTarget:self action:@selector(connectButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    return _connectButton;
}

- (UIImageView *)batteryIcon{
    if (!_batteryIcon) {
        _batteryIcon = [[UIImageView alloc] init];
        _batteryIcon.image = LOADICON(@"MKBeaconPirSensor", @"MKCQScanInfoCell", @"cq_batteryHighest.png");
    }
    return _batteryIcon;
}

- (UILabel *)batteryLabel {
    if (!_batteryLabel) {
        _batteryLabel = [self createLabelWithFont:MKFont(10.f)];
        _batteryLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _batteryLabel;
}

- (UILabel *)macLabel {
    if (!_macLabel) {
        _macLabel = [self createLabelWithFont:MKFont(12.f)];
    }
    return _macLabel;
}

- (UILabel *)txPowerLabel {
    if (!_txPowerLabel) {
        _txPowerLabel = [self createLabelWithFont:MKFont(12.f)];
    }
    return _txPowerLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [self createLabelWithFont:MKFont(10.f)];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _timeLabel;
}

- (UIView *)topBackView {
    if (!_topBackView) {
        _topBackView = [[UIView alloc] init];
    }
    return _topBackView;
}

- (UIView *)centerBackView {
    if (!_centerBackView) {
        _centerBackView = [[UIView alloc] init];
    }
    return _centerBackView;
}

- (UIView *)bottomBackView {
    if (!_bottomBackView) {
        _bottomBackView = [[UIView alloc] init];
    }
    return _bottomBackView;
}

- (UIView *)centerLine {
    if (!_centerLine) {
        _centerLine = [[UIView alloc] init];
        _centerLine.backgroundColor = DEFAULT_TEXT_COLOR;
    }
    return _centerLine;
}

- (UIImageView *)bluePoint {
    if (!_bluePoint) {
        _bluePoint = [[UIImageView alloc] init];
        _bluePoint.image = LOADICON(@"MKBeaconPirSensor", @"MKCQScanInfoCell", @"cq_littleBluePoint.png");
    }
    return _bluePoint;
}

- (UILabel *)pirLabel {
    if (!_pirLabel) {
        _pirLabel = [self createLabelWithFont:MKFont(11.f)];
        _pirLabel.textColor = DEFAULT_TEXT_COLOR;
        _pirLabel.text = @"PIR";
    }
    return _pirLabel;
}

- (UILabel *)rssi1mLabel {
    if (!_rssi1mLabel) {
        _rssi1mLabel = [self createLabelWithFont:MKFont(11.f)];
        _rssi1mLabel.text = @"RSSI@1m";
    }
    return _rssi1mLabel;
}

- (UILabel *)rssi1mValueLabel {
    if (!_rssi1mValueLabel) {
        _rssi1mValueLabel = [self createLabelWithFont:MKFont(11.f)];
    }
    return _rssi1mValueLabel;
}

- (UILabel *)pirSatusLabel {
    if (!_pirSatusLabel) {
        _pirSatusLabel = [self createLabelWithFont:MKFont(11.f)];
        _pirSatusLabel.text = @"PIR status";
    }
    return _pirSatusLabel;
}

- (UILabel *)pirSatusValueLabel {
    if (!_pirSatusValueLabel) {
        _pirSatusValueLabel = [self createLabelWithFont:MKFont(11.f)];
    }
    return _pirSatusValueLabel;
}

- (UILabel *)pirSensitivityLabel {
    if (!_pirSensitivityLabel) {
        _pirSensitivityLabel = [self createLabelWithFont:MKFont(11.f)];
        _pirSensitivityLabel.text = @"PIR sensitivity";
    }
    return _pirSensitivityLabel;
}

- (UILabel *)pirSensitivityValueLabel {
    if (!_pirSensitivityValueLabel) {
        _pirSensitivityValueLabel = [self createLabelWithFont:MKFont(11.f)];
    }
    return _pirSensitivityValueLabel;
}

- (UILabel *)doorStatusLabel {
    if (!_doorStatusLabel) {
        _doorStatusLabel = [self createLabelWithFont:MKFont(11.f)];
        _doorStatusLabel.text = @"Door status";
    }
    return _doorStatusLabel;
}

- (UILabel *)doorStatusValueLabel {
    if (!_doorStatusValueLabel) {
        _doorStatusValueLabel = [self createLabelWithFont:MKFont(11.f)];
    }
    return _doorStatusValueLabel;
}

- (UILabel *)pirDelayLabel {
    if (!_pirDelayLabel) {
        _pirDelayLabel = [self createLabelWithFont:MKFont(11.f)];
        _pirDelayLabel.text = @"PIR delay";
    }
    return _pirDelayLabel;
}

- (UILabel *)pirDelayValueLabel {
    if (!_pirDelayValueLabel) {
        _pirDelayValueLabel = [self createLabelWithFont:MKFont(11.f)];
    }
    return _pirDelayValueLabel;
}

- (UILabel *)majorLabel {
    if (!_majorLabel) {
        _majorLabel = [self createLabelWithFont:MKFont(11.f)];
        _majorLabel.text = @"Major";
    }
    return _majorLabel;
}

- (UILabel *)majorValueLabel {
    if (!_majorValueLabel) {
        _majorValueLabel = [self createLabelWithFont:MKFont(11.f)];
    }
    return _majorValueLabel;
}

- (UILabel *)minorLabel {
    if (!_minorLabel) {
        _minorLabel = [self createLabelWithFont:MKFont(11.f)];
        _minorLabel.text = @"Minor";
    }
    return _minorLabel;
}

- (UILabel *)minorValueLabel {
    if (!_minorValueLabel) {
        _minorValueLabel = [self createLabelWithFont:MKFont(11.f)];
    }
    return _minorValueLabel;
}

- (UILabel *)createLabelWithFont:(UIFont *)font{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = RGBCOLOR(184, 184, 184);
    label.textAlignment = NSTextAlignmentLeft;
    label.font = font;
    return label;
}

@end
