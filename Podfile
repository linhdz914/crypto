# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Tiendientu' do
  pod 'RxSwift', '~> 5.1'
  pod 'RxCocoa', '~> 5.1'
  pod 'RxSwiftExt'
  pod 'RxDataSources', '~> 4.0'
  pod 'SwifterSwift', '~> 5.2.0'
  pod 'Alamofire', '~> 4.3'
  pod 'RxFSPagerView', '~> 0.2'
  pod 'IQKeyboardManagerSwift', "~> 6.5.6"
  pod 'MBProgressHUD', '~> 1.2.0'
  pod 'Toast-Swift', '~> 5.0.1'
  pod 'TagListView', :git => 'https://github.com/ElaWorkshop/TagListView', :branch => 'master'
  pod 'SwiftKeychainWrapper'
  pod 'MBCircularProgressBar'
  pod 'Kingfisher', '~> 7.0'
  pod 'AnimatedCollectionViewLayout'
  pod 'EZYGradientView', :git => 'https://github.com/Niphery/EZYGradientView'
  pod 'BMPlayer', '~> 1.3.0'
  pod 'Charts'
  pod 'DropDown', '2.3.13'
  pod 'EasyTipView', '~> 2.1'
  pod "GWInfinitePickerView"
  pod 'KVKCalendar'
  pod 'GoogleSignIn'
  pod 'AEOTPTextField'
  pod 'SwiftGen', '~> 6.0'
  pod 'SwiftMessages', '7.0.1'
  pod 'FMPhotoPicker', '~> 1.3.0'
  pod 'CameraKit-iOS'
  pod 'NextGrowingTextView'
  pod 'SwiftCharts', '~> 0.6.5'
  pod 'FSCalendar'
#  pod "RichEditorView", :path => "./iStudy/Resources/Libs/RichEditorView"
  pod 'NVActivityIndicatorView'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    if target.respond_to?(:product_type) and target.product_type == "com.apple.product-type.bundle"
      target.build_configurations.each do |config|
        config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
      end
    end
    target.build_configurations.each do |config|
      config.build_settings['ENABLE_BITCODE'] = 'YES'
    end
  end
end
