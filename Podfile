source 'https://cdn.cocoapods.org/'

plugin 'cocoapods-whitelist'

workspace 'AndesUI'
project 'Example/AndesUI.xcodeproj'

platform :ios, '10.0'
use_frameworks!

target 'AndesUI-demoapp' do
    pod 'AndesUI', :path => './'
    pod 'AndesUI/AndesCoachmark', :path => './'
    pod 'AndesUI/AndesBottomSheet', :path => './'
    pod 'AndesUI/AndesDropdown', :path => './'
    pod 'IQKeyboardManagerSwift', '6.5.0'
    pod 'Firebase/Analytics'
    pod 'Firebase/Crashlytics'
    target 'AndesUI_Tests' do
        inherit! :search_paths

        pod 'Quick', '~> 1.2.0'
        pod 'Nimble', '~> 7.3.0'
    end
end

pre_install do |installer|
	`./scripts/install_git_hooks.sh`
end

post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '10.0'
      end
    end
end
