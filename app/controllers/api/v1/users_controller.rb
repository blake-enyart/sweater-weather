class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      api_key = Digest::SHA1.hexdigest(user.email)
      user.update!(api_key: api_key)
      render status: 201,
      json: {
          api_key: user.api_key
      }
      flash[:success] = "Welcome #{user.email}!"
    else
      flash[:error] = user.errors.full_messages
      render :new
    end
  end

  private
    def user_params
      params.permit(:email, :password, :password_confirmation)
    end
end
