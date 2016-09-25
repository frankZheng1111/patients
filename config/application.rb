require File.expand_path('../boot', __FILE__)

require 'rails/all'

require 'log4r'
require 'log4r/yamlconfigurator'
require File.expand_path("../../lib/log4r.rb", __FILE__)
include Log4r

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Patients
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = "zh-CN"

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    if Rails.env != "test"
      log4r_config = YAML.load_file(File.join(File.dirname(__FILE__), "log4r/#{Rails.env}.yml"))
      YamlConfigurator.decode_yaml(log4r_config['log4r_config'])
      config.logger = Log4r::Logger[Rails.env]
    end
  end
end
