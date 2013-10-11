class AuthenticationToken < ActiveRecord::Base

	## Relationship
	belongs_to :user

	## Validations

	validates :auth_token, :user_id, :presence => true

	## Scopes
  scope :current_authentication_token_for_user,
          lambda{|user_id,token|
                where("user_id = ? and auth_token = ?",user_id,token)}


	## Class Methods ##
  class << self
    def generate_unique_token
      token = SecureRandom.hex(20)
      while AuthenticationToken.find_by_auth_token(token)
        token = SecureRandom.hex(20)
      end
      token
    end

    def find_user_from_authentication_token(token)
      u = find_by_auth_token(token, :include => [:user])
      (u.present? && u.user.present?)? u.user : nil
    end

    def create_new_token
      create(:auth_token => AuthenticationToken.generate_unique_token, :last_used_at => Time.now.utc.to_date)
    end

  end

   def update_last_used_at_date
    if self.last_used_at != Time.now.utc.to_date
      self.update_attribute("last_used_at", Time.now.utc.to_date)
    end
  end



end
