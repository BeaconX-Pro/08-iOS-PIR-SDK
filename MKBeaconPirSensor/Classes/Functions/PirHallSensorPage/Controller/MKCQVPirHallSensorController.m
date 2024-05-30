//
//  MKCQVPirHallSensorController.m
//  MKBeaconPirSensor_Example
//
//  Created by aa on 2024/5/30.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import "MKCQVPirHallSensorController.h"

#import "Masonry.h"

#import "MLInputDodger.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"

#import "MKHudManager.h"
#import "MKCustomUIAdopter.h"
#import "MKTableSectionLineHeader.h"

#import "MKCQCentralManager.h"

#import "MKCQPirHallSensorModel.h"

#import "MKCQPirHallSensorHeaderView.h"
#import "MKCQPirSensorCell.h"
#import "MKCQSyncTimeCell.h"

@interface MKCQVPirHallSensorController ()<UITableViewDelegate,
UITableViewDataSource,
MKCQPirSensorCellDelegate,
MKCQSyncTimeCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)MKCQPirHallSensorHeaderView *headerView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)MKCQPirHallSensorModel *dataModel;

@end

@implementation MKCQVPirHallSensorController

- (void)dealloc {
    NSLog(@"MKCQVPirHallSensorController销毁");
    [[MKCQCentralManager shared] notifySensorStatus:NO];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self readDatasFromDevice];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveSensorStatus:)
                                                 name:mk_cq_pirHallSensorStatusChangedNotification
                                               object:nil];
}

#pragma mark - super method

- (void)rightButtonMethod {
    [self saveDataToDevice];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 270.f;
    }
    return 80.f;
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
        MKCQPirSensorCell *cell = [MKCQPirSensorCell initCellWithTableView:tableView];
        cell.dataModel = self.section0List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    MKCQSyncTimeCell *cell = [MKCQSyncTimeCell initCellWithTableView:tableView];
    cell.dataModel = self.section1List[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - MKCQPirSensorCellDelegate
/// 用户选择了Sensitivity
/// - Parameter sensitivity: 0:Low 1:Medium 2:High
- (void)cq_pirSensorCell_sensitivityChanged:(NSInteger)sensitivity {
    self.dataModel.sensitivity = sensitivity;
    MKCQPirSensorCellModel *cellModel = self.section0List[0];
    cellModel.sensitivity = sensitivity;
}

/// 用户选择了delay
/// - Parameter delay: 0:Low 1:Medium 2:High
- (void)cq_pirSensorCell_delayChanged:(NSInteger)delay {
    self.dataModel.delay = delay;
    MKCQPirSensorCellModel *cellModel = self.section0List[0];
    cellModel.delay = delay;
}

#pragma mark - MKCQSyncTimeCellDelegate
- (void)cq_needUpdateDate {
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel syncDateWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        
        MKCQSyncTimeCellModel *cellModel = self.section1List[0];
        cellModel.date = self.dataModel.date;
        cellModel.time = self.dataModel.time;
        
        [self.tableView mk_reloadSection:1 withRowAnimation:UITableViewRowAnimationNone];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - note
- (void)receiveSensorStatus:(NSNotification *)note {
    NSDictionary *dataDic = note.userInfo;
    if (!ValidDict(dataDic)) {
        return;
    }
    [self.headerView updatePirStatus:[dataDic[@"pir"] boolValue] doorStatus:[dataDic[@"hall"] boolValue]];
}

#pragma mark - interface
- (void)readDatasFromDevice {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel readDataWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self loadSectionDatas];
        [[MKCQCentralManager shared] notifySensorStatus:YES];
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
    MKCQPirSensorCellModel *cellModel = [[MKCQPirSensorCellModel alloc] init];
    cellModel.sensitivity = self.dataModel.sensitivity;
    cellModel.delay = self.dataModel.delay;
    [self.section0List addObject:cellModel];
}

- (void)loadSection1Datas {
    MKCQSyncTimeCellModel *cellModel = [[MKCQSyncTimeCellModel alloc] init];
    cellModel.date = self.dataModel.date;
    cellModel.time = self.dataModel.time;
    [self.section1List addObject:cellModel];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"PIR & Hall";
    [self.rightButton setImage:LOADICON(@"MKBeaconPirSensor", @"MKCQVPirHallSensorController", @"cq_slotSaveIcon.png") forState:UIControlStateNormal];
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
        
        _tableView.tableHeaderView = self.headerView;
    }
    return _tableView;
}

- (MKCQPirHallSensorHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[MKCQPirHallSensorHeaderView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 100.f)];
    }
    return _headerView;
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

- (MKCQPirHallSensorModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKCQPirHallSensorModel alloc] init];
    }
    return _dataModel;
}

@end
