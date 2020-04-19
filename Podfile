platform :ios, '12.0'
use_modular_headers!
inhibit_all_warnings!

def pods
  pod 'Dip'
  pod 'KeychainAccess'
  pod 'Logging'
  pod 'Sourcery'
  pod 'SwiftGen'
  pod 'SwiftLint'
end

target 'trader' do
  pods
end

project 'trader', {
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
