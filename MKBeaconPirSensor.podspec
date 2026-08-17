Pod::Spec.new do |s|
  s.name             = 'MKBeaconPirSensor'
  s.version          = '0.0.2'
  s.summary          = 'A short description of MKBeaconPirSensor.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC
  s.homepage         = 'https://github.com/BeaconX-Pro/08-iOS-PIR-SDK'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lovexiaoxia' => 'aadyx2007@163.com' }
  s.source           = { :git => 'https://github.com/BeaconX-Pro/08-iOS-PIR-SDK.git', :tag => s.version.to_s }
  s.ios.deployment_target = '14.0'
  
  # ========== 资源文件 ==========
  s.resource_bundles = {
    'MKBeaconPirSensor' => ['MKBeaconPirSensor/Assets/*.png']
  }
  
  # ========== ConnectManager 层 ==========
  s.subspec 'ConnectManager' do |ss|
    ss.source_files = 'MKBeaconPirSensor/Classes/ConnectManager/**/*.{h,m}'
    ss.dependency 'MKBaseModuleLibrary'
    ss.dependency 'MKBeaconPirSensor/SDK'
  end
  
  # ========== CTMediator 路由层 ==========
  s.subspec 'CTMediator' do |ss|
    ss.source_files = 'MKBeaconPirSensor/Classes/CTMediator/**/*.{h,m}'
    ss.dependency 'CTMediator'
  end
  
  # ========== SDK 层（对外提供，客户只需要这个）==========
  s.subspec 'SDK' do |ss|
    ss.source_files = 'MKBeaconPirSensor/Classes/SDK/**/*.{h,m}'
    ss.dependency 'MKBaseBleModule'
  end
  
  # ========== Target 层 ==========
  s.subspec 'Target' do |ss|
    ss.source_files = 'MKBeaconPirSensor/Classes/Target/**/*.{h,m}'
    ss.dependency 'MKBeaconPirSensor/Functions'
  end
  
  # ========== Functions 层（包含所有页面，客户不需要）==========
  s.subspec 'Functions' do |ss|
    ss.source_files = 'MKBeaconPirSensor/Classes/Functions/**/*.{h,m}'
    
    ss.dependency 'MKBeaconPirSensor/ConnectManager'
    ss.dependency 'MKBeaconPirSensor/SDK'
    ss.dependency 'MKBeaconPirSensor/CTMediator'
    
    ss.dependency 'MKBaseModuleLibrary'
    ss.dependency 'MKCustomUIModule'
    ss.dependency 'MKBeaconXCustomUI'
    ss.dependency 'HHTransition'
    ss.dependency 'MLInputDodger'
    ss.dependency 'NordicDFU', '4.16.0'
  end
  
end
