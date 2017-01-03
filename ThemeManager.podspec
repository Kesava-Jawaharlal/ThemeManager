Pod::Spec.new do |s|
  s.name             = 'ThemeManager'
  s.version          = '0.1.0'
  s.summary          = 'This library is a simpler way to theme the app using plist files. Right now there isnt a generic way to theme the app, which can be used both while using storyboard as well as autolayout from code. This project aims to solve this issue.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'This library is a simpler way to theme the app using plist files. Right now there isnt a generic way to theme the app, which can be used both while using storyboard as well as autolayout from code. This project aims to solve this issue.'

  s.homepage         = 'https://github.com/Kesava-Jawaharlal/ThemeManager'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Kesavasankar Jawaharlal' => ']kesava.jawaharlal@gmail.com' }
  s.source           = { :git => 'https://github.com/Kesava-Jawaharlal/ThemeManager.git', :tag => s.version }
  s.ios.deployment_target = '8.3'
  s.source_files = 'ThemeManager/Classes/**/*.swift'
  
end
