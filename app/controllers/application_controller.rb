class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_filter :current_user
  
  def current_user
    User.find_by(api_key: session[:api_key])
  end
end
