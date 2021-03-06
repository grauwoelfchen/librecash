module Localization
  extend ActiveSupport::Concern

  included do
    around_action :set_locale

    def current_locale
      I18n.locale
    end
    helper_method :current_locale

    private

    # helper methods

    def available_locales
      Rails.application.config.i18n.available_locales.map(&:to_s)
    end

    def valid_locale(detected_locale)
      detected_locale.in?(available_locales) ? detected_locale.intern : nil
    end

    def user_locale
      current_user ? valid_locale(current_user.locale) : nil
    end

    def extract_lang_from_http_accept_language
      request.env['HTTP_ACCEPT_LANGUAGE'].to_s.scan(/^[a-z]{2}/).first
    end

    def accept_lang
      valid_locale(extract_lang_from_http_accept_language)
    end

    def locale_is_changed?
      self.respond_to?(:user_params, true) &&
        params[:user] &&
        user_locale != user_params[:locale]
    end

    def detected_locale
      user_locale || accept_lang || I18n.default_locale
    end

    # actions

    def set_locale
      I18n.locale = detected_locale
      yield
      I18n.locale = detected_locale if locale_is_changed?
    end
  end
end
