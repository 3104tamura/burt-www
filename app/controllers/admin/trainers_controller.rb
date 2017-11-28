# frozen_string_literal: true

class Admin::TrainersController < ApplicationController
  before_action :authenticate
  before_action :set_trainers
  def index; end

  private

  def set_trainers
    @trainers = Trainer.all
  end

  def authenticate
    authenticate_or_request_with_http_basic('Administration') do |username, password|
      username == Rails.application.secrets.basic[:account] && password == Rails.application.secrets.basic[:password]
    end
  end
end
