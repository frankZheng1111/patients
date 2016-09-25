class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale

  rescue_from Exception do |exception|
    error_log_msg = "Error time: #{Time.new}. Error message: #{exception} \n\t"
    exception.backtrace.each { |msg| error_log_msg += "#{msg}\n\t" }
    logger.error error_log_msg
    throw exception
    # flash[:alert] = t("other.error_message")
    # redirect_to :back
  end

  rescue_from ActiveRecord::RecordInvalid do |exception|
    flash[:alert] = exception.message
    redirect_to_back
  end

  protected
  def set_locale
    if params[:locale] && I18n.available_locales.include?(
      params[:locale].to_sym )
      session[:locale] = params[:locale]
    end

    I18n.locale = session[:locale] || I18n.default_locale
  end

  def redirect_to_back(default = root_path)
    if request.env["HTTP_REFERER"].present? &&
       request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
      redirect_to :back
    else
      redirect_to root_path
    end
  end
end
