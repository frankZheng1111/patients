class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale

  rescue_from Exception do |exception|
    logger.error "Error time: #{Time.new}. Error message: #{exception}"
    logger.error "Error message location: \n\t#{exception.backtrace.first}"
    throw exception
    # flash[:alert] = t("other.error_message")
    # redirect_to :back
  end

  rescue_from ActiveRecord::RecordInvalid do |exception|
    flash[:alert] = exception.message
    redirect_to :back
  end

  protected
  def set_locale
    if params[:locale] && I18n.available_locales.include?(
      params[:locale].to_sym )
      session[:locale] = params[:locale]
    end

    I18n.locale = session[:locale] || I18n.default_locale
  end
end
