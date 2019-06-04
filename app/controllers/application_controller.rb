class ApplicationController < ActionController::Base
  def current_user
    User.find_by(api_key: session[:api_key])
  end
end
