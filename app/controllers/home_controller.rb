class HomeController < ApplicationController

	before_filter :authenticate_user!	
	
  layout "login", :only => [:login]

  def login
  	unless current_user.present?
  		redirect_to new_users_session_path
  	else
  		redirect_to root_path
  	end
  end

  def dashboard
    redirect_to users_path
  end

end
