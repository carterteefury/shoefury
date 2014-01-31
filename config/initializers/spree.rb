# Configure Spree Preferences
# 
# Note: Initializing preferences available within the Admin will overwrite any changes that were made through the user interface when you restart.
#       If you would like users to be able to update a setting with the Admin it should NOT be set here.
#
# In order to initialize a setting do: 
# config.setting_name = 'new value'
Spree.config do |config|
  # Example:
  # Uncomment to override the default site name.
  
  config.site_name = "Karnl"
  config.allow_guest_checkout = false
  config.auto_capture = true
  
  if Rails.env.production? || Rails.env.staging?    # configure to use S3 for images in production
    config.use_s3 = true
    config.s3_access_key = ENV["S3_KEY"]
    config.s3_secret = ENV["S3_SECRET"]
    config.s3_bucket = "karnl"
  end

end
