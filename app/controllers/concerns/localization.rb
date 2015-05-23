module Localization
  extend ActiveSupport::Concern

  included do
    before_action :set_locale

    def current_locale
      session[:locale]
    end
    helper_method :current_locale

    private

    # helper methods

    def available_locales
      Rails.application.config.i18n.available_locales.map(&:to_s)
    end

    def extract_lang_from_http_accept_language
      request.env["HTTP_ACCEPT_LANGUAGE"].to_s.scan(/^[a-z]{2}/).first
    end

    def user_locale
      # settings > http_accept_header
      lang = extract_lang_from_http_accept_language
      user_locale = current_user ? (current_user.locale || lang) : lang
      user_locale.in?(available_locales) ? user_locale : nil
    end

    # actions

    def set_locale
      unless session[:locale]
        I18n.locale = (user_locale || I18n.default_locale).intern
        session[:locale] = I18n.locale
      end
    end
  end
end