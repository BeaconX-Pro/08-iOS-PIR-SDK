#
# Be sure to run `pod lib lint MKBeaconPirSensor.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MKBeaconPirSensor'
  s.version          = '0.0.1'
  s.summary          = 'A short description of MKBeaconPirSensor.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/BeaconX-Pro/08-iOS-PIR-SDK'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lovexiaoxia' => 'aadyx2007@163.com' }
  s.source           = { :git => 'https://github.com/BeaconX-Pro/08-iOS-PIR-SDK.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '14.0'
  
  s.resource_bundles = {
    'MKBeaconPirSensor' => ['MKBeaconPirSensor/Assets/*.png']
  }
  
  s.subspec 'ConnectManager' do |ss|
    ss.source_files = 'MKBeaconPirSensor/Classes/ConnectManager/**'
    
    ss.dependency 'MKBaseModuleLibrary'
    
    ss.dependency 'MKBeaconPirSensor/SDK'
  end
  
  s.subspec 'CTMediator' do |ss|
    ss.source_files = 'MKBeaconPirSensor/Classes/CTMediator/**'
    
    ss.dependency 'CTMediator'
  end
  
  s.subspec 'SDK' do |ss|
    ss.source_files = 'MKBeaconPirSensor/Classes/SDK/**'
    ss.dependency 'MKBaseBleModule'
  end
  
  s.subspec 'Target' do |ss|
    ss.source_files = 'MKBeaconPirSensor/Classes/Target/**'
    
    ss.dependency 'MKBeaconPirSensor/Functions'
  end
  
  s.subspec 'Functions' do |ss|
    
    ss.subspec 'AboutPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKBeaconPirSensor/Classes/Functions/AboutPage/Controller/**'
      end
    end

    ss.subspec 'AdvertisementPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKBeaconPirSensor/Classes/Functions/AdvertisementPage/Controller/**'
        
        ssss.dependency 'MKBeaconPirSensor/Functions/AdvertisementPage/Model'
        ssss.dependency 'MKBeaconPirSensor/Functions/AdvertisementPage/View'
      end
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKBeaconPirSensor/Classes/Functions/AdvertisementPage/Model/**'
      end
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKBeaconPirSensor/Classes/Functions/AdvertisementPage/View/**'
      end
    end

    ss.subspec 'DeviceInfoPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKBeaconPirSensor/Classes/Functions/DeviceInfoPage/Controller/**'
        
        ssss.dependency 'MKBeaconPirSensor/Functions/DeviceInfoPage/Model'
      end
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKBeaconPirSensor/Classes/Functions/DeviceInfoPage/Model/**'
      end
    end

    ss.subspec 'PirHallSensorPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKBeaconPirSensor/Classes/Functions/PirHallSensorPage/Controller/**'
        
        ssss.dependency 'MKBeaconPirSensor/Functions/PirHallSensorPage/Model'
        ssss.dependency 'MKBeaconPirSensor/Functions/PirHallSensorPage/View'
      end
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKBeaconPirSensor/Classes/Functions/PirHallSensorPage/Model/**'
      end
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKBeaconPirSensor/Classes/Functions/PirHallSensorPage/View/**'
      end
    end

    ss.subspec 'ScanPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKBeaconPirSensor/Classes/Functions/ScanPage/Controller/**'
        
        ssss.dependency 'MKBeaconPirSensor/Functions/ScanPage/Model'
        ssss.dependency 'MKBeaconPirSensor/Functions/ScanPage/View'

        ssss.dependency 'MKBeaconPirSensor/Functions/TabBarPage/Controller'
        ssss.dependency 'MKBeaconPirSensor/Functions/AboutPage/Controller'
      end
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKBeaconPirSensor/Classes/Functions/ScanPage/Model/**'
      end
      sss.subspec 'View' do |ssss|
        ssss.source_files = 'MKBeaconPirSensor/Classes/Functions/ScanPage/View/**'
        
        ssss.dependency 'MKBeaconPirSensor/Functions/ScanPage/Model'
      end
    end
    
    ss.subspec 'SettingPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKBeaconPirSensor/Classes/Functions/SettingPage/Controller/**'
        
        ssss.dependency 'MKBeaconPirSensor/Functions/SettingPage/Model'

        ssss.dependency 'MKBeaconPirSensor/Functions/PirHallSensorPage/Controller'
        ssss.dependency 'MKBeaconPirSensor/Functions/UpdatePage/Controller'
      end
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKBeaconPirSensor/Classes/Functions/SettingPage/Model/**'
      end
    end

    ss.subspec 'TabBarPage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKBeaconPirSensor/Classes/Functions/TabBarPage/Controller/**'
        
        ssss.dependency 'MKBeaconPirSensor/Functions/AdvertisementPage/Controller'
        ssss.dependency 'MKBeaconPirSensor/Functions/SettingPage/Controller'
        ssss.dependency 'MKBeaconPirSensor/Functions/DeviceInfoPage/Controller'
      end
    end
    
    ss.subspec 'UpdatePage' do |sss|
      sss.subspec 'Controller' do |ssss|
        ssss.source_files = 'MKBeaconPirSensor/Classes/Functions/UpdatePage/Controller/**'
        
        ssss.dependency 'MKBeaconPirSensor/Functions/UpdatePage/Model'
      end
      sss.subspec 'Model' do |ssss|
        ssss.source_files = 'MKBeaconPirSensor/Classes/Functions/UpdatePage/Model/**'
      end
    end

    ss.dependency 'MKBeaconPirSensor/ConnectManager'
    ss.dependency 'MKBeaconPirSensor/SDK'
    ss.dependency 'MKBeaconPirSensor/CTMediator'
    
    ss.dependency 'MKBaseModuleLibrary'
    ss.dependency 'MKCustomUIModule'
    ss.dependency 'MKBeaconXCustomUI'
    ss.dependency 'HHTransition'
    ss.dependency 'MLInputDodger'
    ss.dependency 'iOSDFULibrary',    '4.13.0'
  end
  
end
