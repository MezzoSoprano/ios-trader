platform :ios, '12.0'
use_modular_headers!
inhibit_all_warnings!

def core
  pod 'Core', :git => 'https://hub.teamvoy.com/mobile/awesome-ios', :branch => 'mercury'
end

def pods
  pod 'Dip'
  pod 'KeychainAccess'
  pod 'Logging'
  pod 'Sourcery'
  pod 'SwiftGen'
  pod 'SwiftLint'
end

target 'safeline' do
  core
  pods
end

target 'safelineTests' do
  core
  pods
end

project 'safeline', {
  'Debug' => :debug,
  'Debug-Staging' => :debug,
  'Release' => :release,
  'Release-Staging' => :release
}

post_install do |installer|
  installer.pods_project.targets.each do |target|
   target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end