class Api::V1::PlayerChallengesController < Api::V1::BaseController


  skip_before_action :authentication_user_with_authentication_token, :only => [:index]

  def create
    if params[:player_challenge][:challenge_id].present? && params[:player_challenge][:user_id].present?
      player_challenge_id = params[:player_challenge][:challenge_id]
      player_user_id = params[:player_challenge][:user_id]

      unless PlayerChallenge.find_by_user_id_and_challenge_id(player_challenge_id, player_user_id).present?
        @player_challenge = PlayerChallenge.new(player_challenge_params)
        @player_challenge.avatar = params[:avatar]
        @player_challenge.date_submitted = Time.now.to_date
        if @player_challenge.save
          if @player_challenge.challenge.created_at.to_date == Time.now.to_date
            points = @current_user.points
            day_of_post_point = points + 25
            @current_user.update_attributes(:points => day_of_post_point)
          elsif @player_challenge.challenge.created_at.to_date == Time.now.to_date - 1.day
            points = @current_user.points
            day_of_post_point = points + 21
            @current_user.update_attributes(:points => day_of_post_point)            
          elsif @player_challenge.challenge.created_at.to_date == Time.now.to_date - 2.day
            points = @current_user.points
            day_of_post_point = points + 17
            @current_user.update_attributes(:points => day_of_post_point)            
          elsif @player_challenge.challenge.created_at.to_date == Time.now.to_date - 3.day
            points = @current_user.points
            day_of_post_point = points + 13
            @current_user.update_attributes(:points => day_of_post_point)            
          elsif @player_challenge.challenge.created_at.to_date == Time.now.to_date - 4.day
            points = @current_user.points
            day_of_post_point = points + 9
            @current_user.update_attributes(:points => day_of_post_point)            
          elsif @player_challenge.challenge.created_at.to_date == Time.now.to_date - 5.day
            points = @current_user.points
            day_of_post_point = points + 5
            @current_user.update_attributes(:points => day_of_post_point)            
          else
            points = @current_user.points
            day_of_post_point = points + 1
            @current_user.update_attributes(:points => day_of_post_point)            
          end
          render_json({message: "Successfully Added !", status: 200}.to_json)
        else
          render_json({errors: "Something is wrong. please check parameters !", status: 404}.to_json)
        end
      else
        render_json({message: "Already Reply to this challenge !", status: 200}.to_json)
      end
    else
      render_json({errors: "Something is wrong. please check parameters !", status: 404}.to_json)
    end
  end


  def list_of_player_for_challenge
    challenge_id = params[:challenge_id]
    if challenge_id.present?
      @player = Challenge.find(challenge_id)
      if @player.present?
        @playes_challenge = @player.player_challenges
      else
        render_json({message: "No Data Present Yet !", status: 200}.to_json)
      end
    else
      render_json({errors: "Something is wrong. please check parameters !", status: 404}.to_json)
    end

  end


  protected
  
  def player_challenge_params
    params.require(:player_challenge).permit(:description, :challenge_id, :user_id, :date_submitted, :youtube_link, :make_public, :judge_can_view, :comments_attributes => [:id, :avatar, :description, :challenge_id, :user_id]) 
  end

end