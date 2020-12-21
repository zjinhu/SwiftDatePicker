
Pod::Spec.new do |s|

  s.name         = "SwiftDatePicker"
  s.version      = "1.0.7"
  s.summary      = "A short description of SwiftDatePicker."

  s.homepage         = 'https://github.com/jackiehu/SwiftDatePicker'

  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jackiehu' => 'jackie' }
  s.source           = { :git => 'https://github.com/jackiehu/SwiftDatePicker.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'

  s.dependency 'SnapKit'
  s.dependency 'SwiftShow/Presentation'
  
  s.swift_versions     = ['4.2','5.0','5.1','5.2']
  s.requires_arc = true

  s.subspec 'Tools' do |ss|
    ss.source_files = 'Sources/SwiftDatePicker/Tools/**/*'
  end
    
  s.subspec 'UIKit' do |ss|
    ss.dependency 'SwiftDatePicker/Tools'
    ss.source_files = 'Sources/SwiftDatePicker/UIKit/**/*'
  end
    
  s.subspec 'Custom' do |ss|
    ss.dependency 'SwiftDate'
    ss.dependency 'SwiftDatePicker/Tools'
    ss.source_files = 'Sources/SwiftDatePicker/Custom/**/*'
  end

end
