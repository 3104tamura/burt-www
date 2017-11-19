module OmniAuth
  module Strategies
    class UserFromFacebook < OmniAuth::Strategies::Facebook
      option :name, 'user_from_facebook'
    end
  end
end
