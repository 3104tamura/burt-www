class Admin::UsersController < ApplicationController
  before_action :authenticate
  before_action :set_users
  def index; end

  private

  def set_users
    @users = User.all
  end

  def authenticate
    authenticate_or_request_with_http_basic('Administration') do |username, password|
      username == Rails.application.secrets.basic[:account] && password == Rails.application.secrets.basic[:password]
    end
  end
end
