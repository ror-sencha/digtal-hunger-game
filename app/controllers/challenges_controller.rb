class ChallengesController < ApplicationController

	before_filter :authenticate_user!
	before_action :set_challenge, only: [:show, :edit, :update, :destroy]

	def new
		@challenge = current_user.challenges.build
		@challenge.build_document_challenge unless @challenge.build_document_challenge.present?
		@challenge.build_video_challenge unless @challenge.build_video_challenge.present?
	end

	def create
		@challenge = current_user.challenges.build(challenge_params)
		if @challenge.valid?
			@challenge.save
			redirect_to challenges_path, :notice => "Challenge successfully created."
		else
			render :action => "new"
		end
	end

	def index
		@challenges = Challenge.page(params[:page]).per(10)
	end

	def show
		logger.warn("====testing==========")
		@player_challenges = PlayerChallenge.where("challenge_id = ?", @challenge.id)
	end

	def edit
		@challenge.build_document_challenge unless @challenge.build_document_challenge.present?
		@challenge.build_video_challenge unless @challenge.build_video_challenge.present?
	end

	def update
		respond_to do |format|
       if @challenge.update(challenge_params)
        format.html { redirect_to challenges_path, notice: 'Challenge was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
	end

	def destroy
		@challenge.destroy
    respond_to do |format|
      format.html { redirect_to challenges_url }
    end
	end

	protected  

	def set_challenge
    @challenge = Challenge.find(params[:id])
  end

	def challenge_params
    params.require(:challenge).permit(:is_published, :title, :start_date, :end_date, :description, :document_challenge_attributes => [:id, :avatar], :video_challenge_attributes => [:id, :avatar]) 
  end


end
