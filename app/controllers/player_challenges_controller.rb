class PlayerChallengesController < ApplicationController

	def create
	end

	def update
		@player = PlayerChallenge.find(params[:id])
		if @player.update_attributes(player_params)
			redirect_to root_path, :notice => "Success..!"
		else
			redirect_to :back, :notice => "Error..!"
		end
	end


	protected

	def player_params
		params.require(:player_challenge).permit(:youtube_link, :make_public, :judge_can_view, :comments_attributes => [:id, :avatar, :description, :challenge_id, :user_id]) 
	end



end
