Cloudinary.config do |config|
  config.cloud_name = ENV["SP_CLOUDINARY_CLOUDNAME"]
  config.api_key = ENV["SP_CLOUDINARY_API_KEY"]
  config.api_secret = ENV["SP_CLOUDINARY_API_SECRET"]
  config.cdn_subdomain = true
end

# Cloudinary.config do |config|
#   config.cloud_name = 'africanjober'
#   config.api_key = '779314312381268'
#   config.api_secret = 'yTzH36QeozcV8LUzHJrYIcYT05g'
#   config.cdn_subdomain = true
# end


