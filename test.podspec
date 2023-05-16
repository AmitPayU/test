require 'net/http'

url = URI.parse('https://github.com/payu-intrepos/payu-params-iOS/blob/main/Version.txt')
response = Net::HTTP.get_response(url)

if response.is_a?(Net::HTTPSuccess)
  content = response.body

  # Parse the content or extract variables
  # based on the format of the remote file

  # For example, if the file contains variables in key-value pairs
  variables = {}
  content.each_line do |line|
    key, value = line.chomp.split('=')
    variables[key] = value
  end

  # Use the extracted variables
  variables.each do |key, value|
    puts "#{key}: #{value}"
  end
  
  puts content
else
  puts "Failed to retrieve the remote file. HTTP status code: #{response.code}"
end

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
