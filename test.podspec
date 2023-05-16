
Pod::Spec.new do |s|
  s.name                = "test"
  s.version             = "1.0.5"
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

end
