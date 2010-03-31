# Settings specified here will take precedence over those in config/environment.rb

# The production environment is meant for finished, "live" apps.
# Code is not reloaded between requests
config.cache_classes = true

# Use a different logger for distributed setups
# config.logger = SyslogLogger.new

# Full error reports are disabled and caching is turned on
config.action_controller.consider_all_requests_local = false
config.action_controller.perform_caching             = true

# Enable serving of images, stylesheets, and javascripts from an asset server
# config.action_controller.asset_host                  = "http://assets.example.com"
config.action_controller.session = { :key => "_haneda_api_session", :secret => "9777iup797iu97u9878u9oi79087oi70979u899"}
# Disable delivery errors, bad email addresses will be ignored
# config.action_mailer.raise_delivery_errors = false

#GOOGLE_MAPS_API_KEY = 'ABQIAAAAwZ8rT-mp8NVLYQkw1gyZ0hRwMmC4ffwXeXTpLKGVXe10KonqwRS9UpK0jU6KpvCGKXtaPft5XOJ9pw'
GOOGLE_MAPS_API_KEY = 'ABQIAAAAwZ8rT-mp8NVLYQkw1gyZ0hS_DMC-ZCS_2i8GccQqqpNvqoJxOxTl-AVWqKYbyjXzsTwHp9N89gispw'

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address => "spa.fsr.jp",
  :port => 25,
  :domain => "spa.fsr.jp",
  :user_name => nil,
  :password => nil,
  :authentication => nil,
  }
