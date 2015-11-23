class CommentsController < ApplicationController
    before_action :authenticate_user, except: [:index, :show]

    def index
      @comment = Comment.all
    end

    def new
      @comment = Comment.new
    end

    def create
      @post = Post.find params[:post_id]
      comment_params = params.require(:comment).permit(:title, :body)
      @comment = current_user.comments.new comment_params
      @comment.post = @post
      if @comment.save
        CommentsMailer.notify_post_owner(@comment).deliver_now
        redirect_to post_path(@post), notice: "Comment created successfully"
      else
        render "posts/show"
      end
    end

    def show
      @comment = Comment.find params[:id]
    end

    def edit
      @comment = Comment.find params[:id]
    end

    def update
      comment_params = params.require(:comment).permit(:body)
      @comment = Comment.find params[:id]
      if @comment.update(comment_params)
        redirect_to post_path(@comment.post), notice: "Comment updated successfully"
      else
        render :edit
      end
    end

    def destroy
      @comment = Comment.find params[:id]
      @comment.destroy
      redirect_to post_path(@comment.post), notice: "Comment deleted successfully"
    end



end
