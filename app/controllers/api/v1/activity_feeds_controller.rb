class Api::V1::ActivityFeedsController < Api::V1::BaseController

  #skip_before_action :authentication_user_with_authentication_token, :only => [:index]

  def index
  	@activity_feeds = ActivityFeed.all
    @user = @current_user
  end

  def create
    @activty_feed = ActivityFeed.new(activity_feed_params)
    @activty_feed.user = @current_user
    if @activty_feed.save
      RecentActivity.create(:user_id => @current_user.id, :rc_type => "activty_feed", :message => "You post comment on activty feed.")
    	render_json({message: "Successfully Added Feed!", status: 200}.to_json)
    else
      render_json({errors: @activty_feed.full_errors, status: 404}.to_json)
    end
  end

  def like_n_dislike_activity_feed
  	@activty_feed = ActivityFeed.find(params[:activity_feed_id])
    like_or_dislike = params[:like_or_dislike]
    if @activty_feed.present? && like_or_dislike.present? 
     # @aflp = ActivityfeedLikepoint.where("activity_feed_id = ? && user_id = ?", @activty_feed.id, @current_user.id)
     @aflp = ActivityfeedLikepoint.find_by_activity_feed_id_and_user_id(@activty_feed.id, @current_user.id)
      unless @aflp.present?
        aflikepoint = @current_user.activityfeed_likepoints.build 
        aflikepoint.point = 5
        aflikepoint.activity_feed_id = @activty_feed.id
        aflikepoint.is_like = "true"
        msg = "Liked!"
        aflikepoint.save
        cu_point = @current_user.points + 5
        @current_user.update_attributes(:points => cu_point)
        RecentActivity.create(:user_id => @current_user.id, :rc_type => "activty_feed_like", :message => "Liked on #{@activty_feed.user.name} activty feed.")
        render_json({message: "#{msg}", status: 200}.to_json)
      else
        if like_or_dislike == "true"
          @aflp.is_like = true
          @aflp.point = 5
          @aflp.save
          cu_point = @current_user.points + @aflp.point
          @current_user.update_attributes(:points => cu_point)
          msg = "Liked!"
        else
          @aflp.update_attributes(:is_like => false, :point => 0)
          msg = "Disliked!"
        end
        RecentActivity.create(:user_id => @current_user.id, :rc_type => "activty_feed_like", :message => "Liked on #{@activty_feed.user.name} activty feed.")
        render_json({message: "#{msg}", status: 200}.to_json)
      end
    else
      render_json({errors: "Something is wrong..", status: 404}.to_json)
    end
  end

  def comment_on_activity_feed
    id = params[:activity_feed_id]
    msg = params[:message]
    if id.present? && msg.present?
      @activity_feed = ActivityFeed.find(id)
  	  @activity_feed.feed_comments.create(:message => params[:message], :user_id => @current_user.id, :point => 5 )
      point = @current_user.points + 5
      @current_user.update_attributes(:points => point)
      @activity_feed.save
      RecentActivity.create(:user_id => @current_user.id, :rc_type => "activty_feed_comment", :message => "Comment on #{@activity_feed.user.name} activty feed.")
      render_json({message: "Successfully add comments", status: 200}.to_json)
    else
      render_json({errors: "Message can't be blank!", status: 404}.to_json)
    end
  end


  protected

  def activity_feed_params
    params.require(:activity_feed).permit(:message, :avatar, :user_id, :liked_by)     
  end

  def feed_comment_params
    params.require(:comment).permit(:message, :user_id)     
  end

end