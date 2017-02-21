Pod::Spec.new do |s|
  s.name         = "SGTReactView"
  s.version      = "0.0.1"
  s.summary      = "This is a study pod sp. provide MVVM base function on top of reactivecocoa."

  s.description  = <<-DESC
  This is a study Podspec. Provide SGTReactView function. Base on ReactiveCocoa, Design with MVVM, It's a study frame work'
                   DESC

  s.homepage     = "https://bitbucket.org/sgtfundation/sgtreactview"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "吴磊" => "w.leo.sagittarius@gmail.com" }
  s.source       = { :git => "https://bitbucket.org/sgtfundation/sgtreactview.git", :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3.0' }

  s.source_files  = "Source/**/*.{h,m,swift}"
  s.resources = 'Resource/**/*.{png,pdf,xib,bundle,strings,plist}'

  s.dependency 'SGTUIKit'
  s.dependency 'MGSwipeTableCell'
  s.dependency 'MJRefresh_S'
  s.dependency 'MBProgressHUD'
  s.dependency 'DZNEmptyDataSet'
  s.dependency 'CocoaLumberjack'
  s.dependency 'ReactiveCocoa'
  s.dependency 'ReactiveSwift'
  s.dependency 'Typhoon'
  s.dependency 'SnapKit'

end
