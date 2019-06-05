class Api::V1::UsersController < ApplicationController
  def create
    user_info = JSON.parse(request.body.read, symbolize_names: true)
    user = User.new(user_info)
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
end
