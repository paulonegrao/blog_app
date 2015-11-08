class PostsController < ApplicationController

  def index
    @post = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    post_params = params.require(:post).permit(:title, :body)
    @post = Post.new post_params
    if @post.save
      redirect_to post_path(@post), notice: "Post created successfully"
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @post = Post.find params[:id]
    # @post.comments.sort { |a,b| a.created_at <=> b.created_at }
    # using database command instead to speed up
    @post_comments = @post.comments.order(created_at: :DESC)
  end

  def edit
    @post = Post.find params[:id]
  end

  def update
    post_params = params.require(:post).permit(:title, :body)
    @post = Post.find params[:id]
    if @post.save
      redirect_to post_path(@post) , notice: "Post updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find params[:id]
    @post.destroy
    redirect_to posts_path, notice: "Post deleted successfully"
  end

end
