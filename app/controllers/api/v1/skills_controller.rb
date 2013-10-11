class Api::V1::SkillsController < Api::V1::BaseController

  skip_before_action :authentication_user_with_authentication_token, :only => [:index]

  def index
    @skills = Skill.all
  end

end