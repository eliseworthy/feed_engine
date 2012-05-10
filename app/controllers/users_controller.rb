class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      @user.send_welcome_email
      redirect_to dashboard_path, notice: "Thank you for signing up!"
    else
      render "new"
    end
  end
end
