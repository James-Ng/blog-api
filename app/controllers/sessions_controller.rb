class SessionsController < ApplicationController

  def create
    user_email = params[:session][:email]
    user_password = params[:session][:password]

    user = user_email.present? && User.find_by(email:user_email, password: user_password)

    if user
      user.generate_auth_token
      user.save
      render json: user, status: :ok
    else
      render json: { errors: "Invalid email or password" }, status: :unprocessable_entity
    end
  end


  def destroy
    user = User.find_by(auth_token: params[:id])
    user.generate_auth_token
    user.save
    head 204
  end
end
