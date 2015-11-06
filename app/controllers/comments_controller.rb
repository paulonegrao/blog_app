class CommentsController < ApplicationController

    def index
      @comment = Comment.all
    end

    def new
      @comment = Comment.new
    end

    def create
      comment_params = params.require(:comment).permit(:title, :body)
      @comment = Comment.new comment_params
      if @comment.save
        redirect_to comment_path(@comment), notice: "Comment created successfully"
      else
        render :new
      end
    end

    def show
      @comment = Comment.find params[:id]
    end

    def edit
      @comment = Comment.find params[:id]
    end

    def update
      comment_params = params.require(:comment).permit(:title, :body)
      @comment = Comment.find params[:id]
      if @comment.save
        redirect_to comment_path(@comment) , notice: "Comment updated successfully"
      else
        render :edit
      end
    end

    def destroy
      @comment = Comment.find params[:id]
      @comment.destroy
      redirect_to comments_path, notice: "Comment deleted successfully"
    end



end
