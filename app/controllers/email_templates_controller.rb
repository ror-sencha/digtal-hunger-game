class EmailTemplatesController < ApplicationController
	
	before_filter :authenticate_user!
	before_action :set_email_template, only: [:show, :edit, :update, :destroy]


	def new
		#@email_template = EmailTemplate.new
		#@email_templates = EmailTemplate.all.take(4)
		@registration_email_template 	= EmailTemplate.find_by_name("Registration Email Template")
		@new_challenge_template 	 	= EmailTemplate.find_by_name("New Challenge Template")
		@player_denied_email_template 	= EmailTemplate.find_by_name("Player Denied Email Template")
		@player_winner_email_template	= EmailTemplate.find_by_name("Player Winner Email Template")
	end

	def send_registration_email_template
		@registration_email_template 	= EmailTemplate.find_by_name("Registration Email Template")
    User.list_user_without_admin.each do |user|
      if user.email.present?
        HungerMailer.registration_email_template(@registration_email_template.content, "#{user.email}").deliver
      end
    end
    redirect_to users_path, :notice => "successfully send email to all users!"
	end

	def send_new_challenge_template
		@new_challenge_template 	 	= EmailTemplate.find_by_name("New Challenge Template")
		User.list_user_without_admin.each do |user|
      if user.email.present?
        HungerMailer.new_challenge_template(@new_challenge_template.content, "#{user.email}").deliver
      end
    end
    redirect_to users_path, :notice => "successfully send email to all users!"
	end

	def send_player_denied_email_template
		@player_denied_email_template 	= EmailTemplate.find_by_name("Player Denied Email Template")
		User.list_user_without_admin.each do |user|
     	if user.email.present?
        HungerMailer.player_denied_email_template(@player_denied_email_template.content, "#{user.email}").deliver
      end
    end
    redirect_to users_path, :notice => "successfully send email to all users!"
	end

	def send_player_winner_email_template
		@player_winner_email_template	= EmailTemplate.find_by_name("Player Winner Email Template")
			User.list_user_without_admin.each do |user|
      if user.email.present?
        HungerMailer.player_winner_email_template(@player_winner_email_template.content, "#{user.email}").deliver
      end
    end
    redirect_to users_path, :notice => "successfully send email to all users!"
	end


	def create
		@email_template = EmailTemplate.find(params[:email_template_id])
		if @email_template.update(email_template_params)
			redirect_to root_path
		else
			render action: 'new'
		end
	end

	def edit
	end

	def update
    if @email_template.update(email_template_params)
      redirect_to root_path, notice: 'Mini challenge was successfully updated.'
    else
      render action: 'edit'
    end
	end

	def show
	end

	def destroy
		@email_template.destroy
    redirect_to root_path, notice: 'destroy!'
	end

	protected


	def set_email_template
    @email_template = EmailTemplate.find(params[:id])
  end

	def email_template_params
    params.require(:email_template).permit(:name, :content) 
  end


end
