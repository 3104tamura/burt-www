# frozen_string_literal: true

class TrainersController < ApplicationController
  before_action :set_trainer, only: %w[edit update]
  def index; end
  def edit; end

  def update
    @trainer.attributes = trainer_params
    if @trainer.save(context: :update_profile)
      # NOTE: 暫定
      redirect_to thanks_path
    else
      render :edit
    end
  end

  def from_facebook
    @trainer = Trainer.from_omniauth(request.env['omniauth.auth'])

    if @trainer.persisted?
      if @trainer.new_record?
        redirect_to edit_trainer_path(@trainer)
      else
        sign_out
        # NOTE: 暫定
        redirect_to thanks_path
      end
    else
      session['devise.facebook_data'] = request.env['omniauth.auth']
      redirect_to new_trainer_registration_url
    end
  end

  private

  def set_trainer
    @trainer = Trainer.find(params[:id])
  end

  def trainer_params
    params.require(:trainer).permit(Trainer.column_names.map(&:to_sym) + [category_ids: []])
  end
end
