module UsersHelper
  def actions_for_user(user, options = {})
    result = options.merge({item: user})
    result.merge!({no_destroy: true, no_edit: true}) if user.can_write?
    result
  end
end
