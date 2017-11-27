class PostsController < ApplicationController

  before_action :prepare_user, only: [:index, :create]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = @user.posts
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = @user.posts.build(post_params)

    if @post.save
      redirect_to user_post_path(@user, @post), notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to user_post_path(@post.user, @post), notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to user_posts_url, notice: 'Post was successfully destroyed.'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def prepare_user
    @user = User.find(params[:user_id])
  end

  def post_params
    params.require(:post).permit(:title)
  end

end
