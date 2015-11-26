class UsersController < ApplicationController
  def index
    render json: User.all
  end

  def show
    render json: User.find(params[:id])
  end

  def create
    puts 'Show params[:user][:email] data ' + params[:user][:email].to_s
    puts 'Show params[:user][:name] data ' + params[:user][:name].to_s
    user = User.new(params[:user])
    if user.save
      render json: user, status: 201
    else
      render json: {errors: user.errors }, status: 422
    end
  end

end
