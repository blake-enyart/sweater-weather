class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "You are now logged in as #{user.email}."
      render json: {
        api_key: user.api_key,
      }
    else
      flash[:error] = 'Your credentials are incorrect.'
      render :new # need to build this out
    end
  end
end
