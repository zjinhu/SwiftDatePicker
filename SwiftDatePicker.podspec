
Pod::Spec.new do |spec|

  spec.name         = "SwiftDatePicker"
  spec.version      = "0.1.0"
  spec.summary      = "A short description of SwiftDatePicker."

  s.homepage         = 'https://github.com/jackiehu/SwiftDatePicker'

  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jackiehu' => 'jackie' }
  s.source           = { :git => 'https://github.com/jackiehu/SwiftDatePicker', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'

  s.source_files = 'Sources/**/*'
 
  s.dependency 'SnapKit'
  s.dependency 'SwiftShow'
  s.dependency 'SwiftDate'
  s.swift_versions     = ['4.2','5.0','5.1','5.2']
  s.requires_arc = true

end
