class MiniChallengesController < ApplicationController

	before_filter :authenticate_user!
	before_action :set_mini_challenge, only: [:show, :edit, :update, :destroy]

	def new
		@mini_challenge = current_user.mini_challenges.build
		4.times {@mini_challenge.challenge_options.build} unless @mini_challenge.challenge_options.present?
	end

	def create
		@mini_challenge = current_user.mini_challenges.build(mini_challenge_params)
		if @mini_challenge.valid?
			@mini_challenge.save
			redirect_to users_path, :notice => "Mini challenge successfully created."
		else
			render :action => "new"
		end
	end

	def index
		@mini_challenges = MiniChallenge.page(params[:page]).per(10)
	end

	def edit

	end

	def update
		respond_to do |format|
       if @mini_challenge.update(mini_challenge_params)
        format.html { redirect_to @mini_challenge, notice: 'Mini challenge was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
	end

	def destroy
		@challenge.destroy
    respond_to do |format|
      format.html { redirect_to mini_challenges_url }
    end
	end

	protected  

	def set_challenge
    @challenge = MiniChallenge.find(params[:id])
  end

	def mini_challenge_params
    params.require(:mini_challenge).permit(:title, :question, :is_published, :challenge_options_attributes => [:id, :option, :answer]) 
  end

end
