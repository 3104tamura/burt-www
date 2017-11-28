# frozen_string_literal: true

module Trainers
  class RegistrationsController < Devise::RegistrationsController
    protected

    def after_sign_up_path_for(resource)
      sign_out current_user
      edit_trainer_path(resource)
    end
  end
end
