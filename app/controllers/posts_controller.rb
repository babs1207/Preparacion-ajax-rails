class PostsController < ApplicationController

  before_action :authenticate_user!, except: :index

  def index
    if params[:buscador].present? && params[:buscador].length >2
      @result = Post.where('title like ?', "%#{params[:buscador]}%")
    else
      @post = Post.new
      @posts = Post.order(:id)
    end
  end

  def show
    @post = Post.find(params[:id]) 
    respond_to :js
  end

  def create
    @post = Post.new(title: params[:post][:title])
    @post.user = current_user
    @post.save 
    respond_to :js
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    respond_to :js
  end

  def edit
    @post = Post.find(params[:id]) 
    respond_to :js
  end

  def update
    @post = Post.find(params[:id])
    @post.title = params[:post][:title]
    @post.save
    respond_to :js
  end
end
