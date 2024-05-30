//
//  MKCQDeviceInfoController.m
//  MKBeaconPirSensor_Example
//
//  Created by aa on 2024/5/29.
//  Copyright © 2024 lovexiaoxia. All rights reserved.
//

#import "MKCQDeviceInfoController.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"

#import "MKHudManager.h"
#import "MKNormalTextCell.h"

#import "MKCQDeviceInfoModel.h"

@interface MKCQDeviceInfoController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *dataList;

@property (nonatomic, strong)MKCQDeviceInfoModel *dataModel;

@end

@implementation MKCQDeviceInfoController

- (void)dealloc {
    NSLog(@"MKCQDeviceInfoController销毁");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self startReadDatas];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self loadTableViewDatas];
}

#pragma mark - super method
- (void)leftButtonMethod {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"mk_cq_popToRootViewControllerNotification" object:nil];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKNormalTextCellModel *cellModel = self.dataList[indexPath.row];
    return [cellModel cellHeightWithContentWidth:kViewWidth];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
    cell.dataModel = self.dataList[indexPath.row];
    return cell;
}

#pragma mark - interface
- (void)startReadDatas {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel readWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self loadDatasFromDevice];
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)loadDatasFromDevice {
    MKNormalTextCellModel *batteryModel = self.dataList[0];
    batteryModel.rightMsg = [SafeStr(self.dataModel.battery) stringByAppendingString:@"mV"];
    
    MKNormalTextCellModel *macModel = self.dataList[1];
    macModel.rightMsg = self.dataModel.macAddress;
    
    MKNormalTextCellModel *productModel = self.dataList[2];
    productModel.rightMsg = self.dataModel.produce;
    
    MKNormalTextCellModel *softwareModel = self.dataList[3];
    softwareModel.rightMsg = self.dataModel.software;
    
    MKNormalTextCellModel *firmwareModel = self.dataList[4];
    firmwareModel.rightMsg = self.dataModel.firmware;
    
    MKNormalTextCellModel *hardwareModel = self.dataList[5];
    hardwareModel.rightMsg = self.dataModel.hardware;
    
    MKNormalTextCellModel *manuDateModel = self.dataList[6];
    manuDateModel.rightMsg = self.dataModel.manuDate;
    
    MKNormalTextCellModel *manufactureModel = self.dataList[7];
    manufactureModel.rightMsg = self.dataModel.manu;
    
    MKNormalTextCellModel *runtimeModel = self.dataList[8];
    runtimeModel.rightMsg = self.dataModel.runningTime;
    
    MKNormalTextCellModel *chipModel = self.dataList[9];
    chipModel.rightMsg = self.dataModel.chipsetModel;
    
    [self.tableView reloadData];
}

#pragma mark - loadSectionDatas
- (void)loadTableViewDatas {
    MKNormalTextCellModel *batteryModel = [[MKNormalTextCellModel alloc] init];
    batteryModel.leftMsg = @"Battery voltage";
    [self.dataList addObject:batteryModel];
    
    MKNormalTextCellModel *macModel = [[MKNormalTextCellModel alloc] init];
    macModel.leftMsg = @"MAC address";
    [self.dataList addObject:macModel];
    
    MKNormalTextCellModel *productModel = [[MKNormalTextCellModel alloc] init];
    productModel.leftMsg = @"Product model";
    [self.dataList addObject:productModel];
    
    MKNormalTextCellModel *softwareModel = [[MKNormalTextCellModel alloc] init];
    softwareModel.leftMsg = @"Software version";
    [self.dataList addObject:softwareModel];
    
    MKNormalTextCellModel *firmwareModel = [[MKNormalTextCellModel alloc] init];
    firmwareModel.leftMsg = @"Firmware version";
    [self.dataList addObject:firmwareModel];
    
    MKNormalTextCellModel *hardwareModel = [[MKNormalTextCellModel alloc] init];
    hardwareModel.leftMsg = @"Hardware version";
    [self.dataList addObject:hardwareModel];
    
    MKNormalTextCellModel *manuDateModel = [[MKNormalTextCellModel alloc] init];
    manuDateModel.leftMsg = @"Manufacture date";
    [self.dataList addObject:manuDateModel];
    
    MKNormalTextCellModel *manufactureModel = [[MKNormalTextCellModel alloc] init];
    manufactureModel.leftMsg = @"Manufacturer";
    [self.dataList addObject:manufactureModel];
    
    MKNormalTextCellModel *runtimeModel = [[MKNormalTextCellModel alloc] init];
    runtimeModel.leftMsg = @"Running time";
    [self.dataList addObject:runtimeModel];
    
    MKNormalTextCellModel *chipModel = [[MKNormalTextCellModel alloc] init];
    chipModel.leftMsg = @"Chipset model";
    [self.dataList addObject:chipModel];
    
    [self.tableView reloadData];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"DEVICE";
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom).mas_offset(-49.f);
    }];
}

#pragma mark - getter
- (MKBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[MKBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (MKCQDeviceInfoModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKCQDeviceInfoModel alloc] init];
    }
    return _dataModel;
}

@end
