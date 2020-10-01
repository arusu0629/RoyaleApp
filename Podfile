# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'Analytics' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Analytics
  pod 'Firebase/Core'
  pod 'Firebase/RemoteConfig'
  pod 'Firebase/Analytics'
  pod 'Firebase/Crashlytics'
#  pod 'Firebase/AdMob'  

  target 'AnalyticsTests' do
    # Pods for testing
  end

end

target 'DataStore' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for DataStore

  target 'DataStoreTests' do
    # Pods for testing
  end

end

target 'Domain' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Domain

  target 'DomainTests' do
    # Pods for testing
  end

end

target 'Presentation' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Presentation
  pod 'Firebase/Analytics'  
  pod 'Firebase/AdMob'

  target 'PresentationTests' do
    # Pods for testing
  end

end

target 'RoyaleApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for RoyaleApp

  target 'RoyaleAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'RoyaleAppUITests' do
    # Pods for testing
  end

end

post_install do |installer|
    installer.aggregate_targets.each do |aggregate_target|
        puts aggregate_target.name
        if aggregate_target.name == 'Pods-RoyaleApp'
          aggregate_target.xcconfigs.each do |config_name, config_file|

            config_file.frameworks.delete('FIRAnalyticsConnector')
            config_file.frameworks.delete('Firebase')
            config_file.frameworks.delete('FirebaseABTesting')
            config_file.frameworks.delete('FirebaseAnalytics')
            config_file.frameworks.delete('FirebaseCore')
            config_file.frameworks.delete('FirebaseCoreDiagnostics')
            config_file.frameworks.delete('FirebaseCrashlytiics')
            config_file.frameworks.delete('FirebaseInstallations')
            config_file.frameworks.delete('FirebaseRemoteConfig')
            config_file.frameworks.delete('GoogleMobileAds')
            config_file.frameworks.delete('GoogleAppMeasurement')
            config_file.frameworks.delete('GoogleDataTransport')
            config_file.frameworks.delete('UserMessagingPlatform')
            config_file.frameworks.delete('GoogleUtilities')
            config_file.frameworks.delete('nanopb')
            config_file.frameworks.delete('PromisesObjC')

            xcconfig_path = aggregate_target.xcconfig_path(config_name)
            config_file.save_as(xcconfig_path)
            end
        end

        if aggregate_target.name == 'Pods-Presentation'
          aggregate_target.xcconfigs.each do |config_name, config_file|

            config_file.frameworks.delete('FIRAnalyticsConnector')
            config_file.frameworks.delete('FirebaseAnalytics')            
            config_file.frameworks.delete('FirebaseCore')
            config_file.frameworks.delete('FirebaseCoreDiagnostics')
            config_file.frameworks.delete('FirebaseInstallations')            
            config_file.frameworks.delete('GoogleDataTransport')
            config_file.frameworks.delete('GoogleUtilities')
            config_file.frameworks.delete('GoogleAppMeasurement')            
            config_file.frameworks.delete('FIRAnalyticsConnector')
            config_file.frameworks.delete('Firebase')
            config_file.frameworks.delete('FirebaseABTesting')
            config_file.frameworks.delete('FirebaseAnalytics')
            config_file.frameworks.delete('FirebaseCore')
            config_file.frameworks.delete('FirebaseCoreDiagnostics')
            config_file.frameworks.delete('FirebaseCrashlytiics')
            config_file.frameworks.delete('FirebaseInstallations')
            config_file.frameworks.delete('FirebaseRemoteConfig')
            config_file.frameworks.delete('GoogleAppMeasurement')
            config_file.frameworks.delete('GoogleDataTransport')
            config_file.frameworks.delete('UserMessagingPlatform')
            config_file.frameworks.delete('GoogleUtilities')
            config_file.frameworks.delete('nanopb')
            config_file.frameworks.delete('PromisesObjC')

            xcconfig_path = aggregate_target.xcconfig_path(config_name)
            config_file.save_as(xcconfig_path)
          end
        end
    end
end
