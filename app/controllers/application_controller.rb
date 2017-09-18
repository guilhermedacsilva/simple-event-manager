class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  layout :resolve_layout

  private

  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path
  end

  def resolve_layout
    user_signed_in? ? 'signed_in' : 'application'
  end

  def only_admin!
    redirect_to root_path unless current_user.admin?
  end

  def only_dev_env!
    raise 'error' if Rails.env.production?
  end
end