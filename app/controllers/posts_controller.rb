class PostsController < ApplicationController
  before_action :authenticate_user!
#  before_action :authenticate

  def new
    @post = Post.new()
    @post.author= current_user.name + " " + current_user.surname
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      @post.save
      flash[:notice] = "Post dodany pomyślnie"
    else
      flash[:danger] = "Nie dodano posta!"
    end
    redirect_to posts_path
  end

  def edit
    @post = Post.find(params[:id])
  end

  def index
    @posts = Post.page(params[:page]).per(10)
  end

  def published
    @posts = Post.where(published: true)
    render action: "index"
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:notice] = "Usunięto post!"
    redirect_to posts_path
  end

  def confirm_destroy
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
      if @post.update_attributes(post_params)
        flash[:notice] = "Zedytowano post!"
        redirect_to posts_path
      else
        render action: 'edit'
      end
  end


  private

  def post_params
    params.require(:post).permit(:title, :author, :body, :published)
  end

end
