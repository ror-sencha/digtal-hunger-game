class User::SessionsController < Devise::SessionsController

  layout "login"

  protected

  def after_sign_in_path_for(resource)
    #if resource.is_admin?
    #  dashboard_path
    #else
      users_path
    #end
  end

end