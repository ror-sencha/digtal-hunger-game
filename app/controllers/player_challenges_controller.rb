class PlayerChallengesController < ApplicationController

	before_filter :authenticate_user!

	def create
	end

	def update
		@player = PlayerChallenge.find(params[:player_challenge][:player_challenge_id])
		@user = current_user
		logger.warn("=========#{@user.inspect }===========")
		if @player.update_attributes(player_params)
			if @player.youtube_link.present?
				if @player.activityfeed_id.present? 
					actifeed = ActivityFeed.find(@player.activityfeed_id)
					actifeed.update_attributes(:message => "#{@player.youtube_link}", :user_id => @user.id)
				else
					actifeed = ActivityFeed.create(:message => "#{@player.youtube_link}", :user_id => @user.id )
					@player.activityfeed_id = actifeed.id
					@player.save
				end
			end
			redirect_to challenges_path, :notice => "Success..!"
		else
			redirect_to :back, :notice => "Error..!"
		end
	end

	def declare_winner
		if params[:id].present?
			@player = PlayerChallenge.find(params[:id])
			if @player.is_winner == true
				@player.is_winner = false
			else
				@player.is_winner = true
			end
			@player.save
			msg = @player.is_winner == true ? "Winner" : "Not Winner"
			redirect_to :back, :notice => "#{@player.user.name} is  #{msg}! for #{@player.challenge.title} challenge"
		else
			redirect_to :back, :notice => "Error..!"
		end			
	end


	protected

	def player_params
		params.require(:player_challenge).permit(:youtube_link, :make_public, :judge_can_view, :comments_attributes => [:id, :avatar, :description, :challenge_id, :user_id]) 
	end



end
