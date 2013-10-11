require 'csv'
require 'roo'
class UsersController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:change_password, :reset_password]

  def index
      if params[:search].present?
        @users = User.search(params[:search]).page(params[:page]).per(10)
      else
        @users = User.page(params[:page]).per(10)
      end
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
    #@user.skip_confirmation!
    @user.confirmation_token = nil
    @user.confirmed_at  = Time.now
  	if @user.save
  		redirect_to root_path, :notice => "Successfully Created!"
  	else
  		render "new"
  	end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to users_path, :notice => "Successfully Updated User!"
    else
      render :action => "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, :notice => "Successfully destroy user!"
  end


  def import_users
    @user = User.new
  end

  def post_import_from_csv
    User.import(params[:user][:csv_file])
    redirect_to users_path, :notice => "Uploaded Successfully"
  end

  def change_password
    @user = User.find_by_reset_password_token(params[:reset_password_token])
  end

  def scoreboard
    @player_challenges = PlayerChallenge.all
  end


  protected  

  def user_params
    params.require(:user).permit(:name, :last_name, :email, :password, :password_confirmation,:avatar, :sex, :title, :company, :bio, :status) 
  end


end
