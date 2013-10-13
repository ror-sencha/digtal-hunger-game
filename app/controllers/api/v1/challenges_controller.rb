class Api::V1::ChallengesController < Api::V1::BaseController


  skip_before_action :authentication_user_with_authentication_token, :only => [:index]

  def index
    @challenges = Challenge.where("is_published = ?", true)
    @user =  User.find(params[:user_id])
    @user
  end

  def challenge_like
  	if params[:challenge_id].present?
  		@challenge  = Challenge.find(params[:challenge_id])
  		if @challenge.challenge_likes.where("user_id = ? && challenge_id = ?", @current_user.id, @challenge.id).present?
  			render_json({message: "Point already added !", status: 200}.to_json)
  		else
  			total_like = @challenge.likes + 1
  			@challenge.likes = total_like
  			@challenge.challenge_likes.build(:user_id => @current_user.id )
  			@challenge.recent_activities.build()
  			@challenge.save
  			render_json({message: "Point added !", status: 200}.to_json)
  		end
  	else
  		render_json({errors: "Please Enter Challenge Id for Like a Challenge", status: 404}.to_json)
  	end	
  end


  protected
  
  def challenge_params
    params.require(:challenge).permit()     
  end

  def likes_params
  	params.require(:likes).permit
  end

end