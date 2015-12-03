class CommentsMailer < ApplicationMailer

  def notify_post_owner(comment)
    @comment   = comment
    @post = comment.post
    @owner    = @post.user
    if @owner.email.present?
      mail(to: @owner.email, subject: "You got a new comment!")
    end
  end

  def summary_post_owner(user, post, comment_array)
    @user_first_name = user.first_name
    email           = user.email
    @post_title = post.title
    @comment_array = comment_array
    if @owner.email.present?
      mail(to: user.email, subject: "You got new comment(s)!")
    end
  end

end
