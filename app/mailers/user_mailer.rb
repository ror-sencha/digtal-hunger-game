class UserMailer < ActionMailer::Base
  default from: "no-reply@hunger_game.com"

  def send_forget_password_request(email,token)
  	@email = email
  	@random_token = token
  	mail(:to => email, :subject => "Welcome to HUnger Game",
  			 :bcc => ["dipak@complitech.net"]
  		)
  end


end
