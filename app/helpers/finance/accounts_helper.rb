module Finance
  module AccountsHelper
    def account_icons
      Rails.application.config.icons.to_a
    end
  end
end
