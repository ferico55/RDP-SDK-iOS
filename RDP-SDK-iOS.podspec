#
# Be sure to run `pod lib lint RDP-SDK-iOS.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'RDP-SDK-iOS'
s.version          = '0.1.38'
s.summary          = 'meaningless summary he said!! pasdif asdf asdfj aiwepfj iasjdf.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = <<-DESC
some description over here, he said it was meaningless! asdf awepf jaspd fojaispd fjaoisdp fjapiosdj fapsdi jfpaisd fojiaspdfj apsodi jfapisdoj fipasd jfiapdsjf io
DESC

s.homepage         = 'https://github.com/ferico55/RDP-SDK-iOS'
# s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'ferico55' => 'ferico55@gmail.com' }
s.source           = { :git => 'https://github.com/ferico55/RDP-SDK-iOS.git', :tag => "#{s.version}" }
# s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

s.ios.deployment_target = '8.0'
s.requires_arc = false

#s.default_subspec = 'Core', 'CardIO'
s.default_subspec = 'Core'

s.subspec 'Core' do |subspec|
#s.source_files =
subspec.source_files     = 'RDP-SDK-iOS/Classes/**/*'
#subspec.header_mappings_dir = 'RDP-SDK-iOS/Classes/Public'
subspec.public_header_files = 'RDP-SDK-iOS/Classes/**/*.h'
#subspec.private_header_files = 'RDP-SDK-iOS/Classes/Private/**/*.h'
#subspec.preserve_path    = [ 'PayPalMobile/*.a' ]
subspec.frameworks       = 'Accelerate', 'AudioToolbox', 'AVFoundation', 'CoreLocation', 'CoreMedia', 'MessageUI', 'MobileCoreServices', 'SystemConfiguration'
#subspec.vendored_libraries = [ 'PayPalMobile/libPayPalMobile.a' ]
subspec.compiler_flags   = '-fmodules'
subspec.xcconfig         = { 'OTHER_LDFLAGS' => '-lc++ -ObjC'}
subspec.dependency       'CardIO'
end

#s.subspec 'CardIO' do |subspec|
#end

end
