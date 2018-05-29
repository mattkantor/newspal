class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  def current_permission
    @current_permission ||= ::Permissions.permission_for(current_user)
  end

end
