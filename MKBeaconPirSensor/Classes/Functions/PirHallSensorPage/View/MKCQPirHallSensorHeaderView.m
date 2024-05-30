//
//  MKCQPirHallSensorHeaderView.m
//  MKBeaconPirSensor_Example
//
//  Created by aa on 2024/5/30.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import "MKCQPirHallSensorHeaderView.h"

#import "Masonry.h"

#import "MKMacroDefines.h"

@interface MKCQPirHallSensorHeaderView ()

@property (nonatomic, strong)UIView *backView;

@property (nonatomic, strong)UIImageView *pirIcon;

@property (nonatomic, strong)UILabel *pirLabel;

@property (nonatomic, strong)UILabel *pirValueLabel;

@property (nonatomic, strong)UIImageView *doorIcon;

@property (nonatomic, strong)UILabel *doorLabel;

@property (nonatomic, strong)UILabel *doorValueLabel;

@end

@implementation MKCQPirHallSensorHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = RGBCOLOR(242, 242, 242);
        [self addSubview:self.backView];
        
        [self.backView addSubview:self.pirIcon];
        [self.backView addSubview:self.pirLabel];
        [self.backView addSubview:self.pirValueLabel];
        
        [self.backView addSubview:self.doorIcon];
        [self.backView addSubview:self.doorLabel];
        [self.backView addSubview:self.doorValueLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
        make.top.mas_equalTo(5);
        make.bottom.mas_equalTo(-5);
    }];
    [self.pirIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.width.mas_equalTo(30.f);
        make.top.mas_equalTo(10.f);
        make.height.mas_equalTo(30.f);
    }];
    [self.pirLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.pirIcon.mas_right).mas_offset(5.f);
        make.width.mas_equalTo(100.f);
        make.centerY.mas_equalTo(self.pirIcon.mas_centerY);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
    [self.pirValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.pirLabel.mas_right).mas_offset(10.f);
        make.right.mas_equalTo(-15.f);
        make.centerY.mas_equalTo(self.pirLabel.mas_centerY);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
    [self.doorIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.width.mas_equalTo(30.f);
        make.top.mas_equalTo(self.pirIcon.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(30.f);
    }];
    [self.doorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.doorIcon.mas_right).mas_offset(5.f);
        make.width.mas_equalTo(100.f);
        make.centerY.mas_equalTo(self.doorIcon.mas_centerY);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
    [self.doorValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.doorLabel.mas_right).mas_offset(10.f);
        make.right.mas_equalTo(-15.f);
        make.centerY.mas_equalTo(self.doorLabel.mas_centerY);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
}

#pragma mark - public method
- (void)updatePirStatus:(BOOL)pirStatus doorStatus:(BOOL)doorStatus {
    self.pirValueLabel.text = (pirStatus ? @"Motion detected" : @"Motion not detected");
    self.doorValueLabel.text = (doorStatus ? @"Open" : @"Closed");
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

- (UIImageView *)pirIcon {
    if (!_pirIcon) {
        _pirIcon = [[UIImageView alloc] init];
        _pirIcon.image = LOADICON(@"MKBeaconPirSensor", @"MKCQPirHallSensorHeaderView", @"cq_pirSensorIcon.png");
    }
    return _pirIcon;
}

- (UILabel *)pirLabel {
    if (!_pirLabel) {
        _pirLabel = [[UILabel alloc] init];
        _pirLabel.textColor = DEFAULT_TEXT_COLOR;
        _pirLabel.textAlignment = NSTextAlignmentLeft;
        _pirLabel.font = MKFont(15.f);
        _pirLabel.text = @"PIR Status";
    }
    return _pirLabel;
}

- (UILabel *)pirValueLabel {
    if (!_pirValueLabel) {
        _pirValueLabel = [[UILabel alloc] init];
        _pirValueLabel.textColor = DEFAULT_TEXT_COLOR;
        _pirValueLabel.textAlignment = NSTextAlignmentCenter;
        _pirValueLabel.font = MKFont(15.f);
        _pirValueLabel.text = @"Motion not detected";
    }
    return _pirValueLabel;
}

- (UIImageView *)doorIcon {
    if (!_doorIcon) {
        _doorIcon = [[UIImageView alloc] init];
        _doorIcon.image = LOADICON(@"MKBeaconPirSensor", @"MKCQPirHallSensorHeaderView", @"cq_doorSensorIcon.png");
    }
    return _doorIcon;
}

- (UILabel *)doorLabel {
    if (!_doorLabel) {
        _doorLabel = [[UILabel alloc] init];
        _doorLabel.textColor = DEFAULT_TEXT_COLOR;
        _doorLabel.textAlignment = NSTextAlignmentLeft;
        _doorLabel.font = MKFont(15.f);
        _doorLabel.text = @"Door Status";
    }
    return _doorLabel;
}

- (UILabel *)doorValueLabel {
    if (!_doorValueLabel) {
        _doorValueLabel = [[UILabel alloc] init];
        _doorValueLabel.textColor = DEFAULT_TEXT_COLOR;
        _doorValueLabel.textAlignment = NSTextAlignmentCenter;
        _doorValueLabel.font = MKFont(15.f);
        _doorValueLabel.text = @"Closed";
    }
    return _doorValueLabel;
}

@end
