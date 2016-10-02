# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'

target 'Cinephile' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Cinephile
pod 'Alamofire', '~> 4.0'
pod 'p2.OAuth2', :git => 'https://github.com/p2/OAuth2', :submodules => true
pod 'SwiftyJSON', '3.0.0'
pod 'R.swift', '~> 3.0.0'
pod 'Kingfisher', '~> 3.0'

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
