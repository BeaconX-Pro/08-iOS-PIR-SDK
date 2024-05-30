//
//  MKCQAdvertisementController.m
//  MKBeaconPirSensor_Example
//
//  Created by aa on 2024/5/28.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import "MKCQAdvertisementController.h"

#import "Masonry.h"

#import "MLInputDodger.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"

#import "MKHudManager.h"
#import "MKTextFieldCell.h"
#import "MKCustomUIAdopter.h"
#import "MKTableSectionLineHeader.h"

#import "MKCQAdvertisementModel.h"

#import "MKCQAdvContentCell.h"
#import "MKCQAdvParaCell.h"

@interface MKCQAdvertisementController ()<UITableViewDelegate,
UITableViewDataSource,
MKTextFieldCellDelegate,
MKCQAdvContentCellDelegate,
MKCQAdvParaCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)MKCQAdvertisementModel *dataModel;

@end

@implementation MKCQAdvertisementController

- (void)dealloc {
    NSLog(@"MKCQAdvertisementController销毁");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.view.shiftHeightAsDodgeViewForMLInputDodger = 50.0f;
    [self.view registerAsDodgeViewForMLInputDodgerWithOriginalY:self.view.frame.origin.y];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self readDatasFromDevice];
}

#pragma mark - super method
- (void)leftButtonMethod {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"mk_cq_popToRootViewControllerNotification" object:nil];
}

- (void)rightButtonMethod {
    [self saveDataToDevice];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 220.f;
    }
    return 200.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MKTableSectionLineHeader *headerView = [MKTableSectionLineHeader initHeaderViewWithTableView:tableView];
    MKTableSectionLineHeaderModel *sectionData = [[MKTableSectionLineHeaderModel alloc] init];
    sectionData.contentColor = RGBCOLOR(242, 242, 242);
    headerView.headerModel = sectionData;
    return headerView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.section0List.count;
    }
    if (section == 1) {
        return self.section1List.count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MKCQAdvContentCell *cell = [MKCQAdvContentCell initCellWithTableView:tableView];
        cell.dataModel = self.section0List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    MKCQAdvParaCell *cell = [MKCQAdvParaCell initCellWithTableView:tableView];
    cell.dataModel = self.section1List[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - MKCQAdvContentCellDelegate
/// 输入框内容发生改变
/// - Parameters:
///   - textId: 0:Major 1:Minor 2:Device Name 3:Serial ID
///   - value: 当前输入框内容
- (void)cq_advContentCell_textFieldValueChanged:(NSInteger)textId value:(NSString *)value {
    MKCQAdvContentCellModel *cellModel = self.section0List[0];
    if (textId == 0) {
        //Major
        cellModel.major = value;
        self.dataModel.major = value;
        return;
    }
    if (textId == 1) {
        //Minor
        cellModel.minor = value;
        self.dataModel.minor = value;
        return;
    }
    if (textId == 2) {
        //Device name
        cellModel.deviceName = value;
        self.dataModel.deviceName = value;
        return;
    }
    if (textId == 3) {
        //Serial ID
        cellModel.serialId = value;
        self.dataModel.serialId = value;
        return;
    }
}

#pragma mark - MKCQAdvParaCellDelegate
- (void)cq_advParaCell_intervalChanged:(NSString *)interval {
    MKCQAdvParaCellModel *cellModel = self.section1List[0];
    cellModel.advInterval = interval;
    self.dataModel.advInterval = interval;
}

- (void)cq_advParaCell_rssiChanged:(NSInteger)rssi {
    MKCQAdvParaCellModel *cellModel = self.section1List[0];
    cellModel.rssi1m = rssi;
    self.dataModel.rssi1m = rssi;
}

- (void)cq_advParaCell_txPowerChanged:(NSInteger)txPower {
    NSLog(@"%ld",txPower);
    MKCQAdvParaCellModel *cellModel = self.section1List[0];
    cellModel.txPower = txPower;
    self.dataModel.txPower = txPower;
}

#pragma mark - interface
- (void)readDatasFromDevice {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel readDataWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self loadSectionDatas];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)saveDataToDevice {
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel configDataWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"Success"];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - loadSectionDatas
- (void)loadSectionDatas {
    [self loadSection0Datas];
    [self loadSection1Datas];
    
    [self.tableView reloadData];
}

- (void)loadSection0Datas {
    MKCQAdvContentCellModel *cellModel = [[MKCQAdvContentCellModel alloc] init];
    cellModel.major = self.dataModel.major;
    cellModel.minor = self.dataModel.minor;
    cellModel.deviceName = self.dataModel.deviceName;
    cellModel.serialId = self.dataModel.serialId;
    [self.section0List addObject:cellModel];
}

- (void)loadSection1Datas {
    MKCQAdvParaCellModel *cellModel = [[MKCQAdvParaCellModel alloc] init];
    cellModel.advInterval = self.dataModel.advInterval;
    cellModel.rssi1m = self.dataModel.rssi1m;
    cellModel.txPower = self.dataModel.txPower;
    [self.section1List addObject:cellModel];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"ADVERTISEMENT";
    [self.rightButton setImage:LOADICON(@"MKBeaconPirSensor", @"MKCQAdvertisementController", @"cq_slotSaveIcon.png") forState:UIControlStateNormal];
    self.view.backgroundColor = RGBCOLOR(242, 242, 242);
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
}

#pragma mark - getter
- (MKBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[MKBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = RGBCOLOR(242, 242, 242);
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)section0List {
    if (!_section0List) {
        _section0List = [NSMutableArray array];
    }
    return _section0List;
}

- (NSMutableArray *)section1List {
    if (!_section1List) {
        _section1List = [NSMutableArray array];
    }
    return _section1List;
}

- (MKCQAdvertisementModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKCQAdvertisementModel alloc] init];
    }
    return _dataModel;
}

@end
