class PostsController < ApplicationController
  before_action :authenticate_user, except: [:index, :show]

  before_action :find_post, only: [:show, :edit, :update, :destroy]

  before_action :authorize, only: [:edit, :update, :destroy]

  def index
    @favorite = params[:favorite]
    if @favorite.present?
      @post = current_user.liked_posts
    else
      @post = Post.all
    end
  end

  def new
      @post = Post.new
  end

  def create
    @post       = Post.new(post_params)
    @post.user  = current_user
    if @post.save
      redirect_to post_path(@post), notice: "Post created successfully"
    else
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
    logger.debug "edit......."
    redirect_to root_path, alert: "Access denied." unless can? :edit, @post
  end

  def update
    if @post.save(post_params)
      redirect_to post_path(@post) , notice: "Post updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "Post deleted successfully"
  end

private

  def post_params
    post_params = params.require(:post).permit([:title, :body, {tag_ids: []}])
  end

  def find_post
    @post = Post.find params[:id]
  end

  def authorize
    logger.debug "auth......."
     redirect_to root_path, alert: "Access denied!" unless can? :manage, @post
  end

end
