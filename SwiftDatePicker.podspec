
Pod::Spec.new do |s|

  s.name         = "SwiftDatePicker"
  s.version      = "0.1.0"
  s.summary      = "A short description of SwiftDatePicker."

  s.homepage         = 'https://github.com/jackiehu/SwiftDatePicker'

  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jackiehu' => 'jackie' }
  s.source           = { :git => 'https://github.com/jackiehu/SwiftDatePicker.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'

  s.source_files = 'Sources/**/*'
 
  s.dependency 'SnapKit'
  s.dependency 'SwiftShow/Presentation'
  s.dependency 'SwiftDate'
  s.swift_versions     = ['4.2','5.0','5.1','5.2']
  s.requires_arc = true

end
