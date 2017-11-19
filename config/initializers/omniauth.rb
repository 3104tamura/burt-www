Rails.application.config.middleware.use OmniAuth::Builder do
  require 'omniauth/strategies/user_from_facebook'
  require 'omniauth/strategies/trainer_from_facebook'

  provider :user_from_facebook,
    Rails.application.secrets.user_from_facebook[:app_id],
    Rails.application.secrets.user_from_facebook[:app_secret],
    scope: [:email],
    info_fields: 'name, first_name, last_name, email'

  provider :trainer_from_facebook,
    Rails.application.secrets.trainer_from_facebook[:app_id],
    Rails.application.secrets.trainer_from_facebook[:app_secret],
    scope: [:email],
    info_fields: 'name, first_name, last_name, email'
end
