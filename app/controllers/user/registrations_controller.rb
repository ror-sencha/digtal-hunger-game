class User::RegistrationsController < Devise::RegistrationsController

  def new
    super
  end

  def create
    @user = User.new(resource_params)
    if @user.save
      redirect_to new_users_session_path, :notice => "Please check your email and confirm your account first."
    else
      render :action => "new"
    end
  end


  protected  

  def resource_params
    params.require(:users).permit(:name, :email, :password, :password_confirmation,:avatar, :sex, :title, :company, :bio, :status) 
  end


end