class PostsController < ApplicationController
  before_filter :authorize, :only => [:create, :edit, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])
    if @post.save
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
  end

  def destroy
  end
end