class PostsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]

  before_action :find_post, only: [:show, :edit, :update, :destroy]

  before_action :authorize, only: [:edit, :update, :destroy]

  def index

    @favorite = params[:favorite]
    if @favorite.present?
      @post = current_user.liked_posts
    else
      redirect_to categories_path
    end
  end

  def new
      @category = Category.all
      @post = Post.new
  end

  def create
    @category       = Category.find(params[:selected_category])
    @post           = Post.new(post_params)
    @post.category  = @category
    @post.user      = current_user
    if @post.save
      redirect_to categories_path, notice: "Post created successfully"
    else
      @category = Category.all
      render :new
    end
  end

  def show
    @comment = Comment.new
    # @post.comments.sort { |a,b| a.created_at <=> b.created_at }
    # using database command instead to speed up
    @post_comments = @post.comments.order(created_at: :DESC)
  end

  def edit
    @category = Category.all
    redirect_to root_path, alert: "Access denied." unless can? :edit, @post
  end

  def update
    @category = Category.find(params[:selected_category])
    @post.category = @category
    if @post.update(post_params)
      redirect_to post_path(@post) , notice: "Post updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to categories_path, notice: "Post deleted successfully"
  end

private

  def post_params
    post_params = params.require(:post).permit([:title, :body, {tag_ids: []}, :image])

  end

  def find_post
    @post = Post.find params[:id]
  end

  def authorize
     redirect_to categories_path, alert: "Access denied!" unless can? :manage, @post
  end

end
