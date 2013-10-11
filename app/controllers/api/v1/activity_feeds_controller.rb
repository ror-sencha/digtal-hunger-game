class Api::V1::ActivityFeedsController < Api::V1::BaseController

  #skip_before_action :authentication_user_with_authentication_token, :only => [:index]

  def index
  	@activity_feeds = ActivityFeed.all
  end

  def create
    @activty_feed = ActivityFeed.new(activity_feed_params)
    @activty_feed.user = @current_user
    if @activty_feed.save
    	render_json({message: "Successfully Added Feed!", status: 200}.to_json)
    else
      render_json({errors: @activty_feed.full_errors, status: 404}.to_json)
    end
  end

  def like_n_dislike_activity_feed
  	@activty_feed = ActivityFeed.find(params[:activity_feed_id])
  	if @activty_feed.present?
      if @activty_feed.is_like == true
  		  @activty_feed.is_like = false
        msg = "Unliked!"
      else
        @activty_feed.is_like = true
        msg = "Liked!"
      end
  		@activty_feed.save
  		render_json({message: "#{msg}", status: 200}.to_json)
  	else
  		render_json({errors: "Something is wrong..", status: 404}.to_json)
  	end
  end

  def comment_on_activity_feed
    id = params[:activity_feed_id]
    msg = params[:message]
    if id.present? && msg.present?
      @activity_feed = ActivityFeed.find(id)
  	  @activity_feed.feed_comments.create(:message => params[:message], :user_id => @current_user.id )
      @activity_feed.save
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