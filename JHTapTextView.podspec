Pod::Spec.new do |s|
  s.name         = 'JHTapTextView'
  s.summary      = 'A subclass of UITextView with text clickable.'
  s.version      = '1.1.0'
  s.license      = { :type => 'MIT'}
  s.authors      = { 'Haocold' => 'xjh093@126.com' }
  s.homepage     = 'https://github.com/xjh093/JHTapTextView'

  s.ios.deployment_target = '8.0'

  s.source       = { :git => 'https://github.com/xjh093/JHTapTextView.git', :tag => s.version}
  
  s.source_files = 'JHTapTextView/*.{h,m}'
  s.requires_arc = true
  s.framework    = 'UIKit'

end