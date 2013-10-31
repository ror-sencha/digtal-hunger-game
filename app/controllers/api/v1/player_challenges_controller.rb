class Api::V1::PlayerChallengesController < Api::V1::BaseController


  skip_before_action :authentication_user_with_authentication_token, :only => [:index]

  def create
    if params[:player_challenge][:challenge_id].present? && params[:player_challenge][:user_id].present?
      player_challenge_id = params[:player_challenge][:challenge_id]
      player_user_id = params[:player_challenge][:user_id]

      unless PlayerChallenge.find_by_user_id_and_challenge_id(player_user_id,player_challenge_id).present?
        @player_challenge = PlayerChallenge.new(player_challenge_params)
        @player_challenge.avatar = params[:avatar]
        @player_challenge.date_submitted = Time.now.to_date
        if @player_challenge.save
          ActivityFeed.create(:message => "Recently participate in #{@player_challenge.challenge.title}", :user_id => @current_user.id )
          #RecentActivity.create(:user_id => @current_user.id, :rc_type => "player_challenge", :message => "You post answer on #{@player_challenge.challenge.title}")
          if @player_challenge.challenge.created_at.to_date == Time.now.to_date
            points = @current_user.points
            day_of_post_point = points + 25
            @current_user.update_attributes(:points => day_of_post_point)
            ch_point = @current_user.challenges_points.build
            ch_point.challenge_id = player_challenge_id
            ch_point.point = 25
            ch_point.save
          elsif @player_challenge.challenge.created_at.to_date == Time.now.to_date - 1.day
            points = @current_user.points.present? ? @current_user.points : 0
            day_of_post_point = points + 21
            @current_user.update_attributes(:points => day_of_post_point)            
            ch_point = @current_user.challenges_points.build
            ch_point.challenge_id = player_challenge_id
            ch_point.point = 21
            ch_point.save
          elsif @player_challenge.challenge.created_at.to_date == Time.now.to_date - 2.day
            points = @current_user.points.present? ? @current_user.points : 0
            day_of_post_point = points + 17
            @current_user.update_attributes(:points => day_of_post_point)            
            ch_point = @current_user.challenges_points.build
            ch_point.challenge_id = player_challenge_id
            ch_point.point = 17
            ch_point.save
          elsif @player_challenge.challenge.created_at.to_date == Time.now.to_date - 3.day
            points = @current_user.points.present? ? @current_user.points : 0
            day_of_post_point = points + 13
            @current_user.update_attributes(:points => day_of_post_point)            
            ch_point = @current_user.challenges_points.build
            ch_point.challenge_id = player_challenge_id
            ch_point.point = 13
            ch_point.save
          elsif @player_challenge.challenge.created_at.to_date == Time.now.to_date - 4.day
            points = @current_user.points.present? ? @current_user.points : 0
            day_of_post_point = points + 9
            @current_user.update_attributes(:points => day_of_post_point)            
            ch_point = @current_user.challenges_points.build
            ch_point.challenge_id = player_challenge_id
            ch_point.point = 9
            ch_point.save
          elsif @player_challenge.challenge.created_at.to_date == Time.now.to_date - 5.day
            points = @current_user.points.present? ? @current_user.points : 0
            day_of_post_point = points + 5
            @current_user.update_attributes(:points => day_of_post_point)            
            ch_point = @current_user.challenges_points.build
            ch_point.challenge_id = player_challenge_id
            ch_point.point = 5
            ch_point.save
          else
            points = @current_user.points.present? ? @current_user.points : 0
            day_of_post_point = points + 1
            @current_user.update_attributes(:points => day_of_post_point)            
            ch_point = @current_user.challenges_points.build
            ch_point.challenge_id = player_challenge_id
            ch_point.point = 1
            ch_point.save
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
      @challenge = Challenge.find(challenge_id)
      if @challenge.present?
        jp1 = JudgePoint.all.map(&:player_challenge_id)
        jp2 = JudgePoint.all.map(&:user_id)
        #@player_challenges = @challenge.player_challenges.where("id not in (?) && user_id not in (?)",jp1,jp2)
        @pc1 = @challenge.player_challenges
        logger.warn("========pc1=====#{@pc1.count}==#{@pc1.inspect}===========")
        @pc2 = @challenge.player_challenges.joins("left judge_points") unless JudgePoint.count == 0
        logger.warn("========pc2=====#{@pc2.count}==#{@pc2.inspect}===========")
        if @pc1.present? && @pc2.present?
          @playes_challenge = @pc1 - @pc2 
          logger.warn("========pc3===#{@playes_challenge.inspect}=============")
        else
          @playes_challenge = []
        end
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