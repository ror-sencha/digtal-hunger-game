class Api::V1::BaseController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, :with => :bad_record

  skip_before_action :verify_authenticity_token
  before_action :authentication_user_with_authentication_token


  protected

  def authentication_user_with_authentication_token
    @current_user = AuthenticationToken.find_user_from_authentication_token(params[:auth_token])
    unless @current_user.present?
      render_json({:errors => "You required to register or login before continue to this action!", :status => 401}.to_json)
    end
  end

  def render_json(json)
    callback = params[:callback]
    response = begin
      if callback
        "#{callback}(#{json});"
      else
        json
      end
    end
    render({:content_type => :js, :text => response})
  end

  def bad_record
    render_json({:errors => "No Record Found!", :status => 404}.to_json)
  end

  def parameter_errors
    render_json({:errors => "You have supplied invalid parameter list.", :status => 404}.to_json)
  end

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = '*'
  end
end