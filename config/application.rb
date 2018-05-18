require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
Raven.configure do |config|
  config.environments = ['staging', 'production']
  config.dsn = 'https://81364d3532474e71873c96a57b9e3e5e:ffb3352c29374682afc6ef4c81584594@sentry.io/1209409'
end
module Newspal
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    #config.assets.enabled = false
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
