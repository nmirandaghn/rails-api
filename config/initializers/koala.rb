# In Rails, you could put this in config/initializers/koala.rb
Koala.configure do |config|
  config.app_id = "221272692409169"
  config.app_secret = "b42b422963daaf3a7ded1dfd35e2b619"
  # See Koala::Configuration for more options, including details on how to send requests through
  # your own proxy servers.
end