source 'https://github.com/CocoaPods/Specs'
source 'https://bitbucket.org/sgtfundation/specs'
platform :ios, '8.0'
use_frameworks!
workspace 'SGTMVVMViewWorkSpace'
project 'SGTMVVMView.xcodeproj'
project 'Demo/Demo.xcodeproj'

def all_pods
    pod 'SGTNetworking'#, '~> 2.0.1'
    pod 'SGTUIKit'#, '~> 1.0.8'
    pod 'SGTImageFramework'
    pod 'SGTFileUpload'
    pod 'ReactiveObjC', '~> 1.0.1'
    pod 'MJRefresh_S'
    pod 'MBProgressHUD'#, '~> 0.9.1’
    pod 'DZNEmptyDataSet'#, '~> 1.7.2’
    pod 'CocoaLumberjack'#, '~> 2.0.3’
    pod 'Typhoon', '~> 3.5.1'
    pod 'SnapKit'
    pod 'ReactiveCocoa'
end

target 'SGTMVVMView' do
    project 'SGTMVVMView'
    platform :ios, '8.0'
    
    all_pods
    
end

target 'DemoTests' do
    project 'Demo/Demo'
    platform :ios, '8.0'
    
    all_pods
end

target 'Demo' do
    project 'Demo/Demo'
    platform :ios, '8.0'
    pod 'Reveal-iOS-SDK', :configurations => ['Debug']
    all_pods
#    pod 'SGTReactView', :path => '../SGTReactView'
end
