class CommentsSummaryJob < ActiveJob::Base
  queue_as :default
  def perform(*args)
    @target_date = args[0]
    comments = Comment.where(['created_at::date = ?', @target_date.to_date]).order(:user_id, :post_id)
    user_ant = ""
    post_ant = ""
    comments.each do |c|
      if  user_ant != c.user_id
          send_summary
          @user = User.find_by_id(c.user_id)
          @post = Post.find_by_id(c.post_id)
          @comment_array = []
          post_ant  = c.post_id
          user_ant = c.user_id
      end
      if post_ant  != c.post_id
          send_summary
          @post = Post.find_by_id(c.post_id)
          @comment_array = []
          post_ant  = c.post_id
      end
      @comment_array << c.body
    end
    if @commen_array.count > 0
        send_summary
    end
  end

  def send_summary
    CommentsMailer.summary_post_owner(@user, @post, @target_date, @comment_array).deliver_later
  end
end
