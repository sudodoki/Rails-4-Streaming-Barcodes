class ApplicationController < ActionController::Base
  # helper :application
  include ApplicationHelper
  before_action :authenticate
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate
    redirect_to '/users/sign_in' unless current_user or action_allowed_unauthenticated?
  end
end
