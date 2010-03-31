# Settings specified here will take precedence over those in config/environment.rb

# In the development environment your application's code is reloaded on
# every request.  This slows down response time but is perfect for development
# since you don't have to restart the webserver when you make code changes.
config.cache_classes = false

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Enable the breakpoint server that script/breakpointer connects to
#config.breakpoint_server = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_controller.perform_caching             = false
#config.action_view.cache_template_extensions         = false
config.action_view.debug_rjs                         = true
config.action_controller.session = { :key => "_bukken_session", :secret => "9777iup797iu97u9878u9oi79087oi70979u898"}
# Don't care if the mailer can't send
config.action_mailer.raise_delivery_errors = false

GOOGLE_MAPS_API_KEY = 'ABQIAAAAwZ8rT-mp8NVLYQkw1gyZ0hThonXtF2h3UQcXYop5t8xeTALdhxSOGtQsawJJOHtenVnc00bpq6nDuQ'

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address => "spa.fsr.jp",
  :port => 25,
  :domain => "spa.fsr.jp",
  :user_name => nil,
  :password => nil,
  :authentication => nil,
  }
