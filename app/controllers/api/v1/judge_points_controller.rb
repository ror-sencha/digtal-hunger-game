class Api::V1::JudgePointsController < Api::V1::BaseController


  skip_before_action :authentication_user_with_authentication_token, :only => [:index]

  def create
    user_id = params[:judge_point][:user_id]
    challenge_id = params[:judge_point][:challenge_id]
    if JudgePoint.where("user_id = ? && challenge_id = ? ", user_id, challenge_id).present?
      render_json({errors: "Opps! you already do this.", status: 200}.to_json)
    else
      @judge = JudgePoint.new(judge_params)
      if @judge.save
        RecentActivity.create(:user_id => @current_user.id, :rc_type => "judge_point", :message => "Recently added points.")
        render_json({errors: "Hurry. Successfully Added points", status: 200}.to_json)
      else
        render_json({errors: "Something is wrong. please fix it", status: 404}.to_json)
      end
    end
  end


  protected
  
  def judge_params
    params.require(:judge_point).permit(:user_id, :challenge_id, :points)     
  end
  
end