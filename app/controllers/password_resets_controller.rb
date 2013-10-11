class PasswordResetsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by_email(params[:email])
  	user.send_password_reset if user
  	redirect_to root_url, :notice => "Email sent with password reset instructions."
	end

	def edit
  	@user = User.find_by_reset_password_token!(params[:id])
	end

	def update
	  @user = User.find_by_reset_password_token!(params[:id])
	  if @user.update_attributes(user_params)
	    redirect_to root_url, :notice => "Password has been reset!"
	  else
	    render :edit
	  end
	end

	protected

	def user_params
    params.require(:user).permit(:password, :password_confirmation) 
  end


end
