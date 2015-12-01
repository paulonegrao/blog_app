class CommentsSummaryJob < ActiveJob::Base
  queue_as :default
  def perform(*args)
    comments = Comment.where(['created_at::date = ?', Date.today]).order(:user_id, :post_id)
    user_ant = ""
    post_ant = ""
    comment_array = []
    comments.each do |c|
      if  user_ant != c.user_id
          user = User.find_by_id(c.user_id)
          user_first_name = user.first_name
          email           = user.email
          post = Post.find_by_id(c.post_id)
          post_title = post.title
          post_ant  = c.post_id
          user_ant = c.user_id
      end
      if post_ant  != c.post_id
          CommentsMailer.summary_post_owner(user, post, comment_array).deliver_later
          post_ant  = c.post_id
      end
      byebug
      comment_array << c.body
    end
  end
end
