require 'open-uri'

vars_from_file = URI("https://github.com/payu-intrepos/payu-params-iOS/blob/main/Version.txt").read
eval(vars_from_file)

Pod::Spec.new do |s|
  s.name                = "test"
  s.version             = CommonUI_POD_VERSION
  s.license             = "MIT"
  s.homepage            = "https://github.com/AmitPayU/test"
  s.author              = { "test" => "contact@test.in"  }

  s.summary             = "The SDK provides basic classes and method used across other framewroks"
  s.description         = "The SDK provides basic classes and method used across other framewroks."

  s.source              = { :git => "https://github.com/AmitPayU/test.git",
                            :tag => "#{s.version}"
                          }
  
  s.ios.deployment_target = "11.0"
  s.vendored_frameworks = "test.xcframework"
NATIVE_OTP_ASSIST_PODSPEC_DEPENDENCIES.each do |dependency|
    dependency
end

end
