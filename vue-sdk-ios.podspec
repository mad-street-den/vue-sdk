Pod::Spec.new do |spec|
  spec.name         = "vue-sdk-ios"
  spec.version      = "1.0.0"
  spec.summary      = "VueSDK library for iOS (Swift)"
  spec.description  = "VueSDK is a library/SDK providing all the functions and utilities required to help you build and integrate all the recommendations and search offered by Vue.AI."
  spec.homepage     = "https://github.com/mad-street-den/vue-sdk-ios/tree/main"
  spec.license      = "Apache-2.0"
  spec.author       = { "Mad Street Den Inc." => "developers@madstreetden.com" }
  spec.platform     = :ios
  spec.platform     = :ios, "13.0"
  spec.source       = { :git => "https://github.com/mad-street-den/vue-sdk-ios.git", :tag => spec.version.to_s }
  spec.source_files  = "vue-sdk-ios/**/*.{swift}"
  spec.swift_versions = "5.0"
end