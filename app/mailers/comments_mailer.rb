class CommentsMailer < ApplicationMailer

  def notify_post_owner(comment)
    @comment  = comment
    @post     = comment.post
    @owner    = @post.user
    if @owner.email.present?
      mail(to: @owner.email, subject: "You got a new comment!")
    end
  end

  def summary_post_owner(user, post, target_date, comment_array)
    @user     = user
    @post     = post
    @target_date = target_date
    @owner    = @post.user
    @comment_array = comment_array
    if @owner.email.present?
      mail(to: @owner.email, subject: "You got new comment(s)!")
    end
  end

end
