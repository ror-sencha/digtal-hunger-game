#class HungerMailer < ActionMailer::Base
#HungerMailer.contact_email(@contact).deliver
class HungerMailer < MandrillMailer::TemplateMailer
  default from: "info@solerahungergames.com"



  def registeration_thanks(email)
    mandrill_mail template: 'registeration_thanks',
    subject: "Thanks",
    from: "info@solerahungergames.com",
    from_name: "HungerGame",
    to: {email: email},
    vars: {
       'EMAIL' => email
     }    

  end


  def invitation_for_signup(email,name)
    mandrill_mail template: 'email_for_invitation',
    subject: "Invitation for Join Hunger Game",
    from: "info@solerahungergames.com",
    from_name: "HungerGame",
    to: {email: email},
    vars: {
       'EMAIL' => email,
       'NAME'  => name
     }    

  end

  def email_send_to_md(email, lgnpath)
    mandrill_mail template: 'email_send_to_md',
    subject: "Request",
    from: "info@solerahungergames.com",
    from_name: "HungerGame",
    to: {email: email},
    vars: {
       'EMAIL' => email,
       'MESSAGE' => lgnpath
     }    
  end

  def send_forget_password_request(email,token)
    mandrill_mail template: 'send_forget_password_request',
    subject: "Forget Password",
    from: "info@solerahungergames.com",
    from_name: "HungerGame",
    to: {email: email},
    vars: {
       'EMAIL' => email,
       'TOKEN' => token
     }
  end

  def registration_email_template(email_template, email)
    mandrill_mail template: 'registration_email_template',
    subject: "Registration Email Template",
    from: "info@solerahungergames.com",
    from_name: "HungerGame",
    to: {email: email},
    vars: {
       'EMAIL' => email,
       'MESSAGE' => email_template.content
     }
  end

	def new_challenge_template(email_template, email)
    mandrill_mail template: 'new_challenge_template',
    subject: "New Challenge Template",
    from: "info@solerahungergames.com",
    from_name: "HungerGame",
    to: {email: email},
    vars: {
       'EMAIL' => email,
       'MESSAGE' => email_template.content
     }
  end

  def player_confirmation_template(email_template, email)
    mandrill_mail template: 'player_confirmation_template',
    subject: "Player Confirmation Template",
    from: "info@solerahungergames.com",
    from_name: "HungerGame",
    to: {email: email},
    vars: {
       'EMAIL' => email,
       'MESSAGE' => email_template.html_safe
     }
  end

  def player_denied_email_template(email_template, email)
    mandrill_mail template: 'player_denied_email_template',
    subject: "Player Denied Email Template",
    from: "info@solerahungergames.com",
    from_name: "HungerGame",
    to: {email: email},
    vars: {
       'EMAIL' => email,
       'MESSAGE' => email_template.content
     }
  end

  def player_winner_email_template(email_template, email)
    mandrill_mail template: 'player_winner_email_template',
    subject: "Player Winner Email Template",
    from: "info@solerahungergames.com",
    from_name: "HungerGame",
    to: {email: email},
    vars: {
       'EMAIL' => email,
       'MESSAGE' => email_template.content
     }
  end


  def blast_email(email_template, email)
    mandrill_mail template: 'email_blast',
    subject: "EMAIL BLAST",
    from: "info@solerahungergames.com",
    from_name: "HungerGame",
    to: {email: email},
    vars: {
       'EMAIL' => email,
       'MESSAGE' => email_template
     }
  end

  
end
