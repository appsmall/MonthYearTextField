#
# Be sure to run `pod lib lint MonthYearTextField.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MonthYearTextField'
  s.version          = '0.1.0'
  s.summary          = 'This project is used for debit/credit card month and year expiration field where you can use text field for month and year differently.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
'This project is used for debit/credit card month and year expiration field where you can use text field for month and year differently. You can drag text field from elements tab and drop it into the storyboard view controller. Now, open the Identity Inspector and set the custom custom "MonthYearTextField".'
                       DESC

  s.homepage         = 'https://github.com/appsmall/MonthYearTextField'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'appsmall' => 'rahulchopra.rc93@gmail.com' }
  s.source           = { :git => 'https://github.com/appsmall/MonthYearTextField.git', :tag => s.version.to_s }
#   s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  
  s.ios.deployment_target = '9.0'

  s.source_files = 'Classes/**/*.swift'
  
  s.swift_version = '5.0'
  
  s.platforms = {
      "iOS": "13.0"
  }
  
  # s.resource_bundles = {
  #   'MonthYearTextField' => ['MonthYearTextField/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
