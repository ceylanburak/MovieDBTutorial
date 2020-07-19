# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

platform :ios, '10.0'
target 'IBTechTutorial' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
pod 'Alamofire', '~> 5.2'
pod 'PKHUD', '~> 5.0'

  # Pods for IBTechTutorial

  target 'IBTechTutorialTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'IBTechTutorialUITests' do
    # Pods for testing
  end

end

post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            if config.name == 'IBTechTutorial'
                config.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = 'Yes'
            end
        end
    end
end
