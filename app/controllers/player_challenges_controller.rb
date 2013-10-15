class PlayerChallengesController < ApplicationController

	def create
	end

	def update
		@player = PlayerChallenge.find(params[:player_challenge][:player_challenge_id])
		if @player.update_attributes(player_params)
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
