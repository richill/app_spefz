Cloudinary.config do |config|
  config.cloud_name = ENV["SP_CLOUDINARY_CLOUDNAME"]
  config.api_key = ENV["SP_CLOUDINARY_API_KEY"]
  config.api_secret = ENV["SP_CLOUDINARY_API_SECRET"]
  config.cdn_subdomain = true
end


