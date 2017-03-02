source 'https://github.com/CocoaPods/Specs'
source 'https://github.com/blockdate/PodSpecs'

platform :ios, '8.0'
use_frameworks!
workspace 'SGTMVVMViewWorkSpace'
project 'SGTMVVMView.xcodeproj'
project 'Demo/Demo.xcodeproj'

def all_pods

    pod 'SGTUIKit'
    pod 'MGSwipeTableCell'
    pod 'MJRefresh_S'
    pod 'MBProgressHUD'
    pod 'DZNEmptyDataSet'
    pod 'CocoaLumberjack'
    pod 'Typhoon'#, '~> 3.5.1'
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
