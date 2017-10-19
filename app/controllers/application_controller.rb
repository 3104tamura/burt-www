class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :required_logout!

  # 404, 500のページデザインのため
  #if Rails.env.production?
    rescue_from Exception,                        with: :_render_500
    rescue_from ActiveRecord::RecordNotFound,     with: :_render_404
    rescue_from ActionController::RoutingError,   with: :_render_404
  #end

  def routing_error
    raise ActionController::RoutingError, params[:path]
  end

  def _render_404(e = nil)
    logger.info "Rendering 404 with exception: #{e.message}" if e
    if request.format.to_sym == :json
      render json: { error: '404 error' }, status: :not_found
    else
      render 'errors/404', status: :not_found
    end
  end

  def _render_500(e = nil)
    logger.error "Rendering 500 with exception: #{e.message}" if e
    if request.format.to_sym == :json
      render json: { error: '500 error' }, status: :internal_server_error
    else
      render 'errors/500', status: :internal_server_error
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[nickname gender terms_of_service])
  end

  def required_logout!
    sign_out current_user if user_signed_in?
  end

  def after_sign_out_path_for(_resource_or_scope)
    thanks_path
  end
end
