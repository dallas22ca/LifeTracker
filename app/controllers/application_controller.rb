class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :parse_dates

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password, :subdomain) }
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :current_password, :goal_id) }
  end
  
  def parse_dates
    @start = Time.parse(params[:start]) if params[:start]
    @finish = Time.parse(params[:finish]) if params[:finish]
    @start ||= Time.at(cookies[:start].to_i) if cookies[:start]
    @finish ||= Time.at(cookies[:finish].to_i) if cookies[:finish]
    @start ||= Time.zone.now.beginning_of_month
    @finish ||= Time.zone.now.end_of_month
    cookies[:start] = @start.to_i
    cookies[:finish] = @finish.to_i
  end
end
