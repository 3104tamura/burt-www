# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    protected

    def after_sign_up_path_for(_resource)
      thanks_path
    end
  end
end
