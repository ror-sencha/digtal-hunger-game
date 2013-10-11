class Api::V1::UsersController < Api::V1::BaseController


  skip_before_action :authentication_user_with_authentication_token, :only => [:create, :forget_password, :search, :get_profile, :md_user_type_list]

  def create
    @user = User.new(user_params)
    if params[:skills].present?
      params[:skills].split(",").each do |skill| 
        @user.user_skills.build(:skill_id => skill)
      end
    end
    if params["send_email_to_md"].present? && params["send_email_to_md"].to_s == "true"
      HungerMailer.email_send_to_md(@user.email,"#{DOMAIN_CONFIG}/").deliver
    end

    @user.status = "spectator"
    if @user.save
      @auth_token = @user.create_token
    else
      render_json({errors: @user.full_errors, status: 404}.to_json)
    end
  end

  def forget_password
    email = params[:email]
    if email.present?
      @user = User.find_by_email(email)
      if @user.present?
        random_token = SecureRandom.urlsafe_base64

        present_reset_password_token = User.find_by_reset_password_token(random_token.to_s)
        if present_reset_password_token.present?
          random_token = SecureRandom.urlsafe_base64
        end
        @user.update_attributes(:reset_password_token => random_token)
        cpurl =  change_password_url(:reset_password_token => random_token)
        HungerMailer.send_forget_password_request(email,random_token).deliver
        render_json({message: "Please Check your email for change password.", status: 200}.to_json)        
      else
        render_json({errors: "User is not present with #{email}!", status: 404}.to_json)      
      end
    else
      render_json({errors: "Email can't be blank!", status: 404}.to_json)      
    end
  end

  def get_profile
    if params[:user_id].present?
      @user = User.find(params[:user_id])
      @recent_activity = @user.recent_activities
    else
      render_json({errors: "Opps something is missing. please pass user_id.", status: 404}.to_json)      
    end
  end

  def edit_profile
    @user = @current_user
    if @user.update_attributes(user_params)
      if params[:skills].present?
        @user.user_skills.destroy_all
        params[:skills].split(",").each do |skill| 
          @user.user_skills.build(:skill_id => skill)
        end
      end
      @user.save
      render :file => "api/v1/users/get_profile"
    else
      render_json({errors: @user.full_errors, status: 404}.to_json)
    end
  end

  def endorsement
    user_id = params[:endorse][:user_id]
    skill_id = params[:endorse][:skill_id]
    endorse_id = params[:endorse][:endorse_id]
    @user = User.find(user_id)
    @endorse = User.find(endorse_id)
    @skill = Skill.where("id = ?", skill_id)
    logger.warn("=======test===========")
    if @endorse.is_player?
      if user_id.present? && skill_id.present? && endorse_id.present?
        old_ue = UserEndorse.where("user_id = ? and skill_id = ? and endorse_id = ?", user_id, skill_id, endorse_id)
        unless old_ue.present? 
          u = UserEndorse.new(user_endorse)
          u.save
          RecentActivity.create(:user_id => endorse_id, :rc_type => "endorse", :message => "endorses #{@endorse.name} for #{@skill.name} Skills")
          render_json({message: "Successfully Endorse", status: 200}.to_json)
        else
          render_json({message: "Already Endorse!", status: 200}.to_json)
        end
      else
        render_json({errors: "You are missing something. Require params are user_id, skill_id and endorse_id", status: 404}.to_json)
      end
    else
      render_json({message: "Opps. it's not a player!", status: 200}.to_json)      
    end
  end

  def search
    name = params[:name]
    if name.present?
      @users = User.search(name)
      if @users.present?
        render :file => "api/v1/users/search"        
      else
        render_json({errors: "No User found with #{name}", status: 404}.to_json)
      end
    else
      render_json({errors: "You are missing something. Require params are name", status: 404}.to_json)
    end
  end


  def md_user_type_list
    @md_users = User.list_md
    @video = VideoPage.first if VideoPage.first.present?
  end

  def player_user_list
    @player_users = User.list_player
  end


  def accept_reject_of_player
    @accept_reject_player = User.where("status = ? and md_id IS NOT NULL", "spectator")
  end

  def accept_or_reject_player
    accept = params[:accept_reject]
    @user1 = User.find(params[:user_id])
    if @user1.present?
      if accept.present? && accept.to_s == "accept"
        @user1.status = "player"
        @user1.save
        render_json({message: "Accepted!", status: 200}.to_json)
      elsif accept == "reject"
        @user1.message_for_rejection = params[:message]
        @user1.md_id = nil
        @user1.save
        render_json({message: "#{params[:message]}!", status: 200}.to_json)
      else
        render_json({errors: "accept_reject can't be blank!", status: 404}.to_json)
      end
    else
      render_json({errors: "Passing params is wrong for finding user !", status: 404}.to_json)
    end
  end


  def scoreboard
    @users = User.where("status = ?", "player")
  end

  def social_media_like
    user_id = params[:user_id]
    media_type = params[:status]
    if user_id.present? && media_type.present?
      SocialMediaPoint.
    else
      render_json({errors: "Passing params is wrong for finding user and media!", status: 404}.to_json)
    end
  end

  def support_to_player
    supporter_id = params[:support]
    if supporter_id.present?
      @user = @current_user
      if @user.update_attributes(user_params)
        ## add point (10) for support
        render_json({message: "support added!", status: 200}.to_json)
      else
        render_json({errors: @user.full_errors, status: 404}.to_json)
      end
    else
      render_json({errors: "Passing params is wrong for finding support id!", status: 404}.to_json)
    end
  end

  protected
  
  def user_params
    params.require(:user).permit(:support, :name, :last_name, :email, :password, :password_confirmation,:avatar, :sex, :title, :company, :bio, :status, :skills_attributes, :country, :company_title, :md_id)     
  end

  def skills
    params.permit(:skills)
  end

  def user_endorse
    params.require(:endorse).permit(:user_id, :skill_id, :endorse_id)
  end

end