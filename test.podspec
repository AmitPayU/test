require 'httparty'
require 'colorize'

# Supress warning messages.
original_verbose, $VERBOSE = $VERBOSE, nil

# Make the API request
url = "https://api.github.com/repos/payu-intrepos/payu-params-iOS/contents/Version.txt"
response = HTTParty.get(url)

# Check if the request was successful
if response.code == 200
  # Extract the content from the response
  content = Base64.decode64(response['content'])
  # Evaluate the content of the file
  eval(content)
else
  puts "\n==> Failed to retrieve Version.txt file. HTTP status code: #{response.code}".red
end

# Activate warning messages again.
$VERBOSE = original_verbose

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
  s.vendored_frameworks = "./test.xcframework"
NATIVE_OTP_ASSIST_PODSPEC_DEPENDENCIES.each do |dependency|
    dependency
end

end
