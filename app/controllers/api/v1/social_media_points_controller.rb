class Api::V1::SocialMediaPointsController < Api::V1::BaseController

  skip_before_action :authentication_user_with_authentication_token, :only => [:create]

  def social_media_like
    user_id = params[:social_media][:user_id]
    media_type = params[:social_media][:status]
    challenge_id = params[:social_media][:challenge_id]
    if user_id.present? && media_type.present?
      prev_smp = SocialMediaPoint.where("user_id = ? and challenge_id = ? and media_type = ?", user_id, challenge_id, media_type)
      unless prev_smp.present?
        smp = SocialMediaPoint.new(sml_params)
        smp.points = 1
        smp.media_type = media_type
        smp.save
        point = @current_user.points.present? ? @current_user.points : 0
        social_media_point = point + 1
        @current_user.update_attributes(:points => social_media_point )
        render_json({message: "Succesfully earn points!", status: 200}.to_json)
      else
        render_json({message: "You already earn this points!", status: 200}.to_json)
      end
    else
      render_json({errors: "Passing params is wrong for finding user and media!", status: 404}.to_json)
    end
  end

  protected
  
  def sml_params
    params.require(:social_media).permit(:user_id, :challenge_id, :points, :media_type)
  end

end