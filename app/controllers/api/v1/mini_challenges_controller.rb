class Api::V1::MiniChallengesController < Api::V1::BaseController

  before_action :authentication_user_with_authentication_token

  def index
    @mini_challenges  = MiniChallenge.find(:all, :conditions => ["is_published = ?", true])
  end

  def create
  	mini_challenge_id = params[:mini_challenge][:mini_challenge_id]
  	option = params[:mini_challenge][:option]
    logger.warn("====mini====#{option}========")
  	if mini_challenge_id.present? && option.present?
  		if MiniChallengeAnswer.where("user_id = ? and mini_challenge_id = ?", @current_user.id, mini_challenge_id).present?
  			render_json({message: "Opps.. You Already Given Answer!. so you can't do again", status: 200}.to_json)	
  		else
  			@mc = MiniChallenge.find(mini_challenge_id)
  			@mini_answer = MiniChallengeAnswer.new(mini_challenge_params)
  			@mini_answer.user_id = @current_user.id
  			@mini_answer.save
        ActivityFeed.create(:message => "Recently participate in #{@mc.title} mini challenge!", :user_id => @current_user.id )
        RecentActivity.create(:user_id => @current_user.id, :rc_type => "mini_player_challenge", :message => "Recently post in #{@mc.title} mini challenge")
  			@options = @mc.challenge_options.where("answer = ?", true)
  			if @options.present?
  				current_answer = @options.first.option
  				if option.to_s == current_answer.to_s
	  				points = @current_user.mini_points
  					current_answer_point = points + 10
            @current_user.update_attributes(:mini_points => current_answer_point)
            @mini_points = @current_user.minichallenge_points.build
            @mini_points.points = 10
            @mini_points.mini_challenge_id = @mc.id
            @mini_points.save
						render_json({message: "Hurry! You earn point, you answer is currect.", status: 200}.to_json)	
  				else
  					points = @current_user.mini_points
  					current_answer_point = points + 5 
            @current_user.update_attributes(:mini_points => current_answer_point)
            @mini_points = @current_user.minichallenge_points.build
            @mini_points.points = 5
            @mini_points.mini_challenge_id = @mc.id
            @mini_points.save
						render_json({message: "Oops! your answer is not right.", status: 200}.to_json)	
  				end
  			else
	  			render_json({message: "Please wait for answer. because Answer is not declared.", status: 200}.to_json)	
  			end
  		end
  	else
  		render_json({errors: "Something is wrong.. parameter is not property passed", status: 404}.to_json)
  	end
  end


  protected

  def mini_challenge_params
    params.require(:mini_challenge).permit(:user_id, :mini_challenge_id, :answer) 
  end


end