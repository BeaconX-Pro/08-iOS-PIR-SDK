//
//  MKCQAdvContentCell.m
//  MKBeaconPirSensor_Example
//
//  Created by aa on 2024/5/28.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import "MKCQAdvContentCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"

#import "MKTextField.h"
#import "MKCustomUIAdopter.h"

@implementation MKCQAdvContentCellModel
@end

@interface MKCQAdvContentCell ()

@property (nonatomic, strong)UIView *backView;

@property (nonatomic, strong)UIImageView *leftIcon;

@property (nonatomic, strong)UILabel *typeLabel;

@property (nonatomic, strong)UILabel *majorLabel;

@property (nonatomic, strong)MKTextField *majorTextField;

@property (nonatomic, strong)UILabel *minorLabel;

@property (nonatomic, strong)MKTextField *minorTextField;

@property (nonatomic, strong)UILabel *deviceNameLabel;

@property (nonatomic, strong)MKTextField *deviceNameTextField;

@property (nonatomic, strong)UILabel *serialIdLabel;

@property (nonatomic, strong)MKTextField *serialIdTextField;

@end

@implementation MKCQAdvContentCell

+ (MKCQAdvContentCell *)initCellWithTableView:(UITableView *)tableView {
    MKCQAdvContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKCQAdvContentCellIdenty"];
    if (!cell) {
        cell = [[MKCQAdvContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKCQAdvContentCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = RGBCOLOR(242, 242, 242);
        [self.contentView addSubview:self.backView];
        
        [self.backView addSubview:self.leftIcon];
        [self.backView addSubview:self.typeLabel];
        
        [self.backView addSubview:self.majorLabel];
        [self.backView addSubview:self.majorTextField];
        
        [self.backView addSubview:self.minorLabel];
        [self.backView addSubview:self.minorTextField];
        
        [self.backView addSubview:self.deviceNameLabel];
        [self.backView addSubview:self.deviceNameTextField];
        
        [self.backView addSubview:self.serialIdLabel];
        [self.backView addSubview:self.serialIdTextField];
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
    [self.leftIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.width.mas_equalTo(22.f);
        make.top.mas_equalTo(10.f);
        make.height.mas_equalTo(22.f);
    }];
    [self.typeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftIcon.mas_right).mas_offset(15.f);
        make.right.mas_equalTo(-15.f);
        make.centerY.mas_equalTo(self.leftIcon.mas_centerY);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
    
    [self.majorLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.width.mas_equalTo(110.f);
        make.centerY.mas_equalTo(self.majorTextField.mas_centerY);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
    [self.majorTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.majorLabel.mas_right).mas_offset(40.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.leftIcon.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(30.f);
    }];
    
    [self.minorLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.width.mas_equalTo(110.f);
        make.centerY.mas_equalTo(self.minorTextField.mas_centerY);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
    [self.minorTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.minorLabel.mas_right).mas_offset(40.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.majorTextField.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(30.f);
    }];
    
    [self.deviceNameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.width.mas_equalTo(110.f);
        make.centerY.mas_equalTo(self.deviceNameTextField.mas_centerY);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
    [self.deviceNameTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.minorLabel.mas_right).mas_offset(40.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.minorTextField.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(30.f);
    }];
    
    [self.serialIdLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.width.mas_equalTo(110.f);
        make.centerY.mas_equalTo(self.serialIdTextField.mas_centerY);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
    [self.serialIdTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.minorLabel.mas_right).mas_offset(40.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.deviceNameTextField.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(30.f);
    }];
}

#pragma mark - setter
- (void)setDataModel:(MKCQAdvContentCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKCQAdvContentCellModel.class]) {
        return;
    }
    self.majorTextField.text = SafeStr(_dataModel.major);
    self.minorTextField.text = SafeStr(_dataModel.minor);
    self.deviceNameTextField.text = SafeStr(_dataModel.deviceName);
    self.serialIdTextField.text = SafeStr(_dataModel.serialId);
}

#pragma mark - getter
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = COLOR_WHITE_MACROS;
        
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = 8.f;
    }
    return _backView;
}

- (UIImageView *)leftIcon{
    if (!_leftIcon) {
        _leftIcon = [[UIImageView alloc] init];
        _leftIcon.image = LOADICON(@"MKBeaconPirSensor", @"MKCQAdvContentCell", @"cq_slot_advContent.png");
    }
    return _leftIcon;
}

- (UILabel *)typeLabel{
    if (!_typeLabel) {
        _typeLabel = [MKCustomUIAdopter customTextLabel];
        _typeLabel.text = @"Adv content";
    }
    return _typeLabel;
}

- (UILabel *)majorLabel {
    if (!_majorLabel) {
        _majorLabel = [MKCustomUIAdopter customTextLabel];
        _majorLabel.text = @"Major";
    }
    return _majorLabel;
}

- (MKTextField *)majorTextField {
    if (!_majorTextField) {
        _majorTextField = [MKCustomUIAdopter customNormalTextFieldWithText:@"" placeHolder:@"0~65535" textType:mk_realNumberOnly];
        _majorTextField.maxLength = 5;
        _majorTextField.font = MKFont(15.f);
        @weakify(self);
        _majorTextField.textChangedBlock = ^(NSString * _Nonnull text) {
            @strongify(self);
            if ([self.delegate respondsToSelector:@selector(cq_advContentCell_textFieldValueChanged:value:)]) {
                [self.delegate cq_advContentCell_textFieldValueChanged:0 value:text];
            }
        };
    }
    return _majorTextField;
}

- (UILabel *)minorLabel {
    if (!_minorLabel) {
        _minorLabel = [MKCustomUIAdopter customTextLabel];
        _minorLabel.text = @"Minor";
    }
    return _minorLabel;
}

- (MKTextField *)minorTextField {
    if (!_minorTextField) {
        _minorTextField = [MKCustomUIAdopter customNormalTextFieldWithText:@"" placeHolder:@"0~65535" textType:mk_realNumberOnly];
        _minorTextField.maxLength = 5;
        _minorTextField.font = MKFont(15.f);
        @weakify(self);
        _minorTextField.textChangedBlock = ^(NSString * _Nonnull text) {
            @strongify(self);
            if ([self.delegate respondsToSelector:@selector(cq_advContentCell_textFieldValueChanged:value:)]) {
                [self.delegate cq_advContentCell_textFieldValueChanged:1 value:text];
            }
        };
    }
    return _minorTextField;
}

- (UILabel *)deviceNameLabel {
    if (!_deviceNameLabel) {
        _deviceNameLabel = [MKCustomUIAdopter customTextLabel];
        _deviceNameLabel.text = @"Device name";
    }
    return _deviceNameLabel;
}

- (MKTextField *)deviceNameTextField {
    if (!_deviceNameTextField) {
        _deviceNameTextField = [MKCustomUIAdopter customNormalTextFieldWithText:@"" placeHolder:@"1-10 characters" textType:mk_normal];
        _deviceNameTextField.maxLength = 10;
        _deviceNameTextField.font = MKFont(15.f);
        @weakify(self);
        _deviceNameTextField.textChangedBlock = ^(NSString * _Nonnull text) {
            @strongify(self);
            if ([self.delegate respondsToSelector:@selector(cq_advContentCell_textFieldValueChanged:value:)]) {
                [self.delegate cq_advContentCell_textFieldValueChanged:2 value:text];
            }
        };
    }
    return _deviceNameTextField;
}

- (UILabel *)serialIdLabel {
    if (!_serialIdLabel) {
        _serialIdLabel = [MKCustomUIAdopter customTextLabel];
        _serialIdLabel.text = @"Serial ID";
    }
    return _serialIdLabel;
}

- (MKTextField *)serialIdTextField {
    if (!_serialIdTextField) {
        _serialIdTextField = [MKCustomUIAdopter customNormalTextFieldWithText:@"" placeHolder:@"0~99999" textType:mk_realNumberOnly];
        _serialIdTextField.maxLength = 5;
        _serialIdTextField.font = MKFont(15.f);
        @weakify(self);
        _serialIdTextField.textChangedBlock = ^(NSString * _Nonnull text) {
            @strongify(self);
            if ([self.delegate respondsToSelector:@selector(cq_advContentCell_textFieldValueChanged:value:)]) {
                [self.delegate cq_advContentCell_textFieldValueChanged:3 value:text];
            }
        };
    }
    return _serialIdTextField;
}



- (UILabel *)loadMsgLabel:(NSString *)text {
    UILabel *msgLabel = [[UILabel alloc] init];
    msgLabel.textColor = DEFAULT_TEXT_COLOR;
    msgLabel.textAlignment = NSTextAlignmentLeft;
    msgLabel.font = MKFont(15.f);
    msgLabel.text = text;
    
    return msgLabel;
}

@end
