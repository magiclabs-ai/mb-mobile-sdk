Pod::Spec.new do |spec|
  spec.name         = "MagiclabsSDK"
  spec.version      = "0.0.33"
  spec.summary      = "Magiclabs SDK for iOS"
  spec.description  = "Create designs using the Magiclabs photobook design service"
  spec.homepage     = "https://github.com/magiclabs-ai/mb-mobile-sdk"
  spec.license      = { :type => 'Proprietary', :text => 'Copyright 2024 Magiclabs. All rights reserved.' }
  spec.author       = { "John Ingram" => "john.ingram@magiclabs.ai" }

  spec.platform     = :ios, "15.0"

  spec.source       = { :http => "https://github.com/magiclabs-ai/mb-mobile-sdk/releases/download/0.0.33/MagiclabsSDK.xcframework.zip" }

  spec.vendored_frameworks = "MagiclabsSDK.xcframework"
  spec.preserve_paths = "MagiclabsSDK.xcframework"
end
