require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module LibreCash
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified
    # here. Application configuration should go into files in
    # config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record
    # auto-convert to this zone. Run 'rake -D time' for a list of tasks for
    # finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # model extensions
    config.eager_load_paths += [
      Rails.root.join('app', 'models', 'extensions').to_s
    ]

    # extenders
    config.to_prepare do
      Dir.glob(Rails.root.join('app', 'extenders', '**', '*.rb')) do |file|
        Rails.configuration.cache_classes ? require(file) : load(file)
      end
    end

    # The default locale is :en and all translations from config/locales/*.rb,
    # yml are auto loaded.
    config.i18n.load_path += Dir[
      Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s
    ]
    config.i18n.default_locale = :en
    # rails-i18n
    config.i18n.available_locales = [:en, :ja]

    config.force_ssl = false
  end
end
