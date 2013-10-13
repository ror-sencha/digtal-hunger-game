class VideoPagesController < ApplicationController

	before_filter :authenticate_user!

	def new
		@video_page = VideoPage.new
	end

	def create
		if VideoPage.count.to_i == 0
			@video_page = VideoPage.new(video_params)
			if @video_page.save
				redirect_to users_path, :notice => "Successfully Added Video"
			else
				render :actio => "new"
			end
		else
			@video_page = VideoPage.first
			@video_page.update_attributes(video_params)
			redirect_to users_path, :notice => "Successfully Added Video"
		end

	end

  protected  

  def video_params
    params.require(:video_page).permit(:video_path) 
  end
end
