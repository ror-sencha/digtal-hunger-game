class Api::V1::SessionsController < Api::V1::BaseController
  
  skip_before_action :authentication_user_with_authentication_token, only: [:create]

  def create
    @user, message = User.authenticate(params[:email], params[:password])
    if @user.present?
      @auth_token = @user.create_token
      if @user.current_sign_in_at.present?
        unless @user.current_sign_in_at.to_date == Time.now.to_date
          points = @user.points.present? ? @user.points : 0
          login_points = points + 5
          @user.update_attributes(:points => login_points)
        end
      end
      sign_in_count = @user.sign_in_count + 1
      @user.update_attributes(:current_sign_in_at => Time.now, :sign_in_count => sign_in_count)
      render :file => "api/v1/sessions/create"
    else
      render_json({errors: message, status: 404}.to_json)
    end
  end

  def destroy
    @auth_token = AuthenticationToken.current_authentication_token_for_user(@current_user.id, auth_token_params).first
    if @auth_token.present?
      @auth_token.destroy
    end
    render_json({message: "Successfully logout", status: 200}.to_json)
  end

  private
    def user_params
      params.permit(:email, :password)
    end

    def auth_token_params
      params.permit(:auth_token)
    end
end