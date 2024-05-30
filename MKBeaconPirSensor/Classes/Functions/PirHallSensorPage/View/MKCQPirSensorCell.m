//
//  MKCQPirSensorCell.m
//  MKBeaconPirSensor_Example
//
//  Created by aa on 2024/5/30.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import "MKCQPirSensorCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"

#import "MKCustomUIAdopter.h"

@implementation MKCQPirSensorCellModel
@end

@interface MKCQPirSensorCell ()

@property (nonatomic, strong)UIView *backView;

@property (nonatomic, strong)UILabel *msgLabel;

@property (nonatomic, strong)UILabel *sensitivityLabel;

@property (nonatomic, strong)UIPickerView *sensitivityPickerView;

@property (nonatomic, strong)NSArray *sensitivityPickerList;

@property (nonatomic, assign)NSInteger sensitivityRow;

@property (nonatomic, strong)UILabel *delayLabel;

@property (nonatomic, strong)UIPickerView *delayPickerView;

@property (nonatomic, strong)NSArray *delayPickerList;

@property (nonatomic, assign)NSInteger delayRow;

@end

@implementation MKCQPirSensorCell

+ (MKCQPirSensorCell *)initCellWithTableView:(UITableView *)tableView {
    MKCQPirSensorCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKCQPirSensorCellIdenty"];
    if (!cell) {
        cell = [[MKCQPirSensorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKCQPirSensorCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = RGBCOLOR(242, 242, 242);
        [self.contentView addSubview:self.backView];
        
        [self.backView addSubview:self.msgLabel];
        [self.backView addSubview:self.sensitivityLabel];
        [self.backView addSubview:self.sensitivityPickerView];
        [self.backView addSubview:self.delayLabel];
        [self.backView addSubview:self.delayPickerView];
    }
    return self;
}

#pragma mark - super method
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5.f);
        make.right.mas_equalTo(-5.f);
        make.top.mas_equalTo(5.f);
        make.bottom.mas_equalTo(-5.f);
    }];
    [self.msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(10.f);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
    [self.sensitivityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(self.sensitivityPickerView.mas_left).mas_offset(-15.f);
        make.centerY.mas_equalTo(self.sensitivityPickerView.mas_centerY);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
    [self.sensitivityPickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(100.f);
        make.top.mas_equalTo(self.msgLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(100.f);
    }];
    [self.delayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(self.delayPickerView.mas_left).mas_offset(-15.f);
        make.centerY.mas_equalTo(self.delayPickerView.mas_centerY);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
    [self.delayPickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(100.f);
        make.top.mas_equalTo(self.sensitivityPickerView.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(100.f);
    }];
}

#pragma mark - UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 30.f;
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView == self.sensitivityPickerView) {
        return self.sensitivityPickerList.count;
    }
    if (pickerView == self.delayPickerView) {
        return self.delayPickerList.count;
    }
    return 0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view{
    UILabel *titleLabel = (UILabel *)view;
    if (!titleLabel) {
        titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = DEFAULT_TEXT_COLOR;
        titleLabel.adjustsFontSizeToFitWidth = YES;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = MKFont(12.f);
    }
    BOOL selected = NO;
    if (pickerView == self.sensitivityPickerView && self.sensitivityRow == row) {
        selected = YES;
    }else if (pickerView == self.delayPickerView && self.delayRow == row) {
        selected = YES;
    }
    if(selected){
        /*选中后的row的字体颜色*/
        /*重写- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component NS_AVAILABLE_IOS(6_0) __TVOS_PROHIBITED; 方法加载 attributedText*/
        
        titleLabel.attributedText
        = [self pickerView:pickerView attributedTitleForRow:row forComponent:component];
        
    }else{
        
        titleLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    }
    return titleLabel;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView == self.sensitivityPickerView) {
        return self.sensitivityPickerList[row];
    }
    if (pickerView == self.delayPickerView) {
        return self.delayPickerList[row];
    }
    return @"";
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *title = @"";
    if (pickerView == self.sensitivityPickerView) {
        title = self.sensitivityPickerList[row];
    }else if (pickerView == self.delayPickerView) {
        title = self.delayPickerList[row];
    }
    
    NSAttributedString *attString = [MKCustomUIAdopter attributedString:@[title]
                                                                  fonts:@[MKFont(13.f)]
                                                                 colors:@[NAVBAR_COLOR_MACROS]];
    return attString;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (pickerView == self.sensitivityPickerView) {
        self.sensitivityRow = row;
        if ([self.delegate respondsToSelector:@selector(cq_pirSensorCell_sensitivityChanged:)]) {
            [self.delegate cq_pirSensorCell_sensitivityChanged:row];
        }
    }else if (pickerView == self.delayPickerView) {
        self.delayRow = row;
        if ([self.delegate respondsToSelector:@selector(cq_pirSensorCell_delayChanged:)]) {
            [self.delegate cq_pirSensorCell_delayChanged:row];
        }
    }
    [pickerView reloadAllComponents];
}

#pragma mark - setter
- (void)setDataModel:(MKCQPirSensorCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKCQPirSensorCellModel.class]) {
        return;
    }
    self.sensitivityRow = _dataModel.sensitivity;
    self.delayRow = _dataModel.delay;
    [self.sensitivityPickerView selectRow:_dataModel.sensitivity inComponent:0 animated:YES];
    [self.delayPickerView selectRow:_dataModel.delay inComponent:0 animated:YES];
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
        _msgLabel.text = @"PIR Sensor parameters";
    }
    return _msgLabel;
}

- (UILabel *)sensitivityLabel {
    if (!_sensitivityLabel) {
        _sensitivityLabel = [[UILabel alloc] init];
        _sensitivityLabel.textColor = DEFAULT_TEXT_COLOR;
        _sensitivityLabel.textAlignment = NSTextAlignmentLeft;
        _sensitivityLabel.font = MKFont(15.f);
        _sensitivityLabel.text = @"Sensitivity";
    }
    return _sensitivityLabel;
}

- (UIPickerView *)sensitivityPickerView{
    if (!_sensitivityPickerView) {
        _sensitivityPickerView = [[UIPickerView alloc] init];
        // 显示选中框,iOS10以后分割线默认的是透明的，并且默认是显示的，设置该属性没有意义了，
        _sensitivityPickerView.showsSelectionIndicator = YES;
        _sensitivityPickerView.dataSource = self;
        _sensitivityPickerView.delegate = self;
        
        _sensitivityPickerView.layer.masksToBounds = YES;
        _sensitivityPickerView.layer.borderColor = NAVBAR_COLOR_MACROS.CGColor;
        _sensitivityPickerView.layer.borderWidth = 0.5f;
        _sensitivityPickerView.layer.cornerRadius = 4.f;
    }
    return _sensitivityPickerView;
}

- (NSArray *)sensitivityPickerList {
    if (!_sensitivityPickerList) {
        _sensitivityPickerList = @[@"Low",@"Medium",@"High"];
    }
    return _sensitivityPickerList;
}

- (UILabel *)delayLabel {
    if (!_delayLabel) {
        _delayLabel = [[UILabel alloc] init];
        _delayLabel.textColor = DEFAULT_TEXT_COLOR;
        _delayLabel.textAlignment = NSTextAlignmentLeft;
        _delayLabel.font = MKFont(15.f);
        _delayLabel.text = @"Delay";
    }
    return _delayLabel;
}

- (UIPickerView *)delayPickerView{
    if (!_delayPickerView) {
        _delayPickerView = [[UIPickerView alloc] init];
        // 显示选中框,iOS10以后分割线默认的是透明的，并且默认是显示的，设置该属性没有意义了，
        _delayPickerView.showsSelectionIndicator = YES;
        _delayPickerView.dataSource = self;
        _delayPickerView.delegate = self;
        
        _delayPickerView.layer.masksToBounds = YES;
        _delayPickerView.layer.borderColor = NAVBAR_COLOR_MACROS.CGColor;
        _delayPickerView.layer.borderWidth = 0.5f;
        _delayPickerView.layer.cornerRadius = 4.f;
    }
    return _delayPickerView;
}

- (NSArray *)delayPickerList {
    if (!_delayPickerList) {
        _delayPickerList = @[@"Low",@"Medium",@"High"];
    }
    return _delayPickerList;
}

@end
