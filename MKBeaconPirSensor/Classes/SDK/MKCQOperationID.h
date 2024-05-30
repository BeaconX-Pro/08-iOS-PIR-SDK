
typedef NS_ENUM(NSInteger, mk_cq_taskOperationID) {
    mk_cq_defaultTaskOperationID,
    
    mk_cq_taskReadVendorOperation,                     //读取厂商信息
    mk_cq_taskReadModeIDOperation,                     //读取产品型号信息
    mk_cq_taskReadProductionDateOperation,             //读取生产日期
    mk_cq_taskReadHardwareOperation,                   //读取硬件信息
    mk_cq_taskReadFirmwareOperation,                   //读取固件信息
    mk_cq_taskReadSoftwareOperation,                   //读取软件版本
    
    mk_cq_taskReadMajorOperation,                       //读取Major
    mk_cq_taskConfigMajorOperation,                     //配置Major
    
    mk_cq_taskReadMinorOperation,                       //读取Minor
    mk_cq_taskConfigMinorOperation,                     //配置Minor
                
    mk_cq_taskReadRssiOperation,                        //读取Rssi
    mk_cq_taskConfigRssiOperation,                      //配置Rssi
    
    mk_cq_taskReadTxPowerOperation,                     //读取Tx Power
    mk_cq_taskConfigTxPowerOperation,                   //配置Tx Power
    
    mk_cq_taskConfigPasswordOperation,                  //密码验证
    mk_cq_taskChangePasswordOperation,                  //修改密码
    
    mk_cq_taskReadAdvIntervalOperation,                 //读取广播间隔
    mk_cq_taskConfigAdvIntervalOperation,               //配置广播间隔
    
    mk_cq_taskReadSerialIdOperation,                    //读取Serial ID
    mk_cq_taskConfigSerialIdOperation,                  //配置Serial ID
    
    mk_cq_taskReadDeviceNameOperation,                  //读取设备名称
    mk_cq_taskConfigDeviceNameOperation,                //配置设备名称
    
    mk_cq_taskReadMacAddressOperation,                  //读取mac地址
    
    mk_cq_taskReadConnectableOperation,                 //读取可连接状态
    mk_cq_taskConfigConnectableOperation,               //配置可连接状态
    
    mk_cq_taskFactoryResetOperation,                       //恢复出厂设置
        
    
    mk_cq_taskReadBatteryOperation,                      //读取battery
    mk_cq_taskReadRunningTimeOperation,                 //读取运行总时间
    mk_cq_taskReadChipsetModelOperation,                //读取芯片类型
    mk_cq_taskConfigPowerOffOperation,                  //命令关机
    mk_cq_taskConfigButtonPowerStatusOperation,         //配置按键可关机状态
    mk_cq_taskReadButtonPowerStatusOperation,           //读取按键可关机状态
    mk_cq_taskConfigPIRSensorSensitivityOperation,      //配置PIR灵敏度
    mk_cq_taskReadPIRSensorSensitivityOperation,        //读取PIR灵敏度
    mk_cq_taskConfigPIRSensorDelayOperation,            //配置PIR延时状态
    mk_cq_taskReadPIRSensorDelayOperation,              //读取PIR延时状态
    mk_cq_taskConfigDeviceTimeOperation,                //配置设备当前时间
    mk_cq_taskReadDeviceTimeOperation,                  //读取设备当前时间
};
