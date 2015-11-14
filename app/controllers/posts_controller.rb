class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]

  def index
    @post = Post.all
  end

  def new
    @post = Post.new
  end

  def create
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

end

private

def post_params
  post_params = params.require(:post).permit(:title, :body)
end

def find_post
  @post = Post.find params[:id]
end
