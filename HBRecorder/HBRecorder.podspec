#
# Be sure to run `pod lib lint HBRecorder.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HBRecorder'
  s.version          = '1.0.1'
  s.summary          = 'Video recording - HBRecorder.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'Record videos with pause/start feature and beautiful animations between video segments.'

  s.homepage         = 'https://github.com/hilalbaig/HBRecorder'
  s.screenshots     = 'https://raw.githubusercontent.com/hilalbaig/HBRecorder/master/Screenshots/iPhone6plus%20Screenshot%201.png', 'https://raw.githubusercontent.com/hilalbaig/HBRecorder/master/Screenshots/iPhone6plus%20Screenshot%203.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'HilalB' => 'hilal.beg@gmail.com' }
  s.source           = { :git => 'https://github.com/hilalbaig/HBRecorder.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/hilalbaig'

  s.ios.deployment_target = '9.0'

  s.source_files = 'HBRecorder/Classes/**/*'
  
	s.resource_bundles = {
	    'HBRecorder' => ['HBRecorder/Assets/*.{lproj,storyboard}']
	  }
		
	s.resources = "HBRecorder/Assets/*.xcassets"
	


  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'SCRecorder'
end
