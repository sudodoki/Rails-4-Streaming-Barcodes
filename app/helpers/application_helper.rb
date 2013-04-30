module ApplicationHelper
  def current_user
    session[:user_id] ? @current_user ||= User.find(session[:user_id]) rescue session[:user_id] = nil : nil
  end

  ALLOWED = {
      "users" => ["sign_in", "sign_up"]
    }
  def action_allowed_unauthenticated?
    controller = params[:controller]
    action = params[:action]
    not (actions = ALLOWED[controller]).nil? and (actions.include? action)
  end
end
