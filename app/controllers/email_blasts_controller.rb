class EmailBlastsController < ApplicationController

	before_filter :authenticate_user!

  def new
    @email_blast = EmailBlast.new
  	@email_blasts = EmailBlast.first
  end

  def create
  	@email_blast = EmailBlast.find(params[:email_blast_id])
		if @email_blast.update(email_blast_params)
			redirect_to root_path
		else
			render action: 'new'
		end
  end

  def send_email_blast
    template = EmailBlast.first
    group = params[:user_group]
    if group.downcase.to_s == "spectator"
      logger.warn("=======spec===")
      User.list_spectator.each do |user|
        if user.email.present?
          HungerMailer.blast_email(template.content, "#{user.email}").deliver
        end
      end
    elsif group.downcase.to_s == "md"
      logger.warn("=======md===")
      User.list_md.each do |user|
        if user.email.present?
          HungerMailer.blast_email(template.content, "#{user.email}").deliver
        end
      end
    elsif group.downcase.to_s == "judge"
      User.list_md.each do |user|
        if user.email.present?
          HungerMailer.blast_email(template.content, "#{user.email}").deliver
        end
      end                  
    elsif group.downcase.to_s == "player"
      User.list_player.each do |user|
        if user.email.present?
          HungerMailer.blast_email(template.content, "#{user.email}").deliver
        end
      end              
    elsif group.downcase.to_s == "all user"    
      User.all.each do |user|
        if user.email.present?
          HungerMailer.blast_email(template.content, "#{user.email}").deliver
        end
      end            
    end
    redirect_to root_path, :notice => "Successfully send email blast."
  end


  protected

	def set_email_blast
    @email_blast = EmailBlast.find(params[:id])
  end

	def email_blast_params
    params.require(:email_blast).permit(:title, :content) 
  end
end
