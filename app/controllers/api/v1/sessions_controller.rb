class Api::V1::SessionsController < ApplicationController
  def create
    request_info = JSON.parse(request.body.read, symbolize_names: true)
    user = User.find_by(email: request_info[:email])
    if user && user.authenticate(request_info[:password])
      flash[:success] = "You are now logged in as #{user.email}."
      render json: {
        api_key: user.api_key,
      }
    else
      flash[:error] = 'Your credentials are incorrect.'
      render :new # need to build this view out
    end
  end
end
