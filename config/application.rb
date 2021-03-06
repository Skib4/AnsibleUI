require_relative 'boot'

require 'rails/all'
#I18n.available_locales = [:en, :pl]
#config.i18n.default_locale = :pl

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ansibleui
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    #config.load_defaults 6.0
    config.i18n.default_locale = :pl
    config.action_view.field_error_proc = Proc.new { |html_tag, instance| 
    	html_tag
    }	
	# Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
