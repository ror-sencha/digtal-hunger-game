class Api::V1::UsersController < Api::V1::BaseController

  skip_before_action :authentication_user_with_authentication_token, :only => [:create, :forget_password, :search, :md_user_type_list]

  def create
    @user = User.new(user_params)
    @import_user = User.find_by_email(params[:user][:email])
    if params[:skills].present?
      params[:skills].split(",").each do |skill| 
        @user.user_skills.build(:skill_id => skill)
        @import_user.user_skills.build(:skill_id => skill) if @import_user.present?
      end
    end
    if params["send_email_to_md"].present? && params["send_email_to_md"].to_s == "true"
      HungerMailer.email_send_to_md(@user.email,"#{DOMAIN_CONFIG}/").deliver
    end
    logger.warn("=======1======#{@import_user.inspect}=========")
    if @import_user.present?
      if @import_user.sign_in_count == 0 && !@import_user.current_sign_in_at.nil?
        @import_user.update_attributes(user_params)
        if @import_user.save
           @import_user.confirmed_at = Time.now unless @user.confirmed_at.present?
           @user = @import_user
        end
      else
        render_json({errors: "Email already present!", status: 404}.to_json)
      end
    else
      @user.status = "spectator"
      @user.current_sign_in_at = Time.now
      if @user.save
        @user.confirmed_at  = Time.now unless @user.confirmed_at.present?
        @auth_token = @user.create_token
        logger.warn("======auth_token==2===#{@auth_token}======")
        HungerMailer.registeration_thanks(@user.email).deliver
      else
        render_json({errors: @user.full_errors, status: 404}.to_json)
      end
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
        RecentActivity.create(:user_id => @user.id, :rc_type => "forget_password", :message => "You recently send email for forget password.")
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
      @recent_activity = @user.recent_activities.limit(20).order("created_at DESC")
      @player_challenges = @user.player_challenges
      @cuser = @current_user
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
      RecentActivity.create(:user_id => @user.id, :rc_type => "update_profile", :message => "Your profile is successfully updated")      
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
    @skill = Skill.find(skill_id)
    if @endorse.is_player?
      if user_id.present? && skill_id.present? && endorse_id.present?
        old_ue = UserEndorse.where("user_id = ? and skill_id = ? and endorse_id = ?", user_id, skill_id, endorse_id)
        unless old_ue.present? 
          u = UserEndorse.new(user_endorse)
          u.save
          RecentActivity.create(:comment_id => user_id, :user_id => endorse_id, :rc_type => "endorse", :message => "endorses #{@endorse.name} for #{@skill.name} Skill")
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
        HungerMailer.md_accept_request(@user1.email).deliver
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
    @users = User.where("status = ? && confirmed_at IS NOT NULL", "player")
  end

  def social_media_like
    user_id = params[:user_id]
    media_type = params[:status]
    if user_id.present? && media_type.present?
      #SocialMediaPoint.create()
      render_json({message: "Liked!", status: 200}.to_json)
      #RecentActivity.create(:user_id => @current_user.id, :rc_type => "social_media_like", :message => "you liked in #{media_type}")
    else
      render_json({errors: "Passing params is wrong for finding user and media!", status: 404}.to_json)
    end
  end

  def support_to_player
    supporter_id = params[:support]
    if supporter_id.present?
      @supporter = User.find(supporter_id)
      @user = @current_user
      @user.support = supporter_id
      @user.points = @user.points + 10
      if @user.save
        ## add point (10) for support
        support_user = @current_user.support_points.build
        support_user.point = 10
        support_user.support_id = supporter_id
        support_user.save
        RecentActivity.create(:user_id => @user.id, :rc_type => "support_to_player", :message => "#{@supporter.fullname} will support you.")
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