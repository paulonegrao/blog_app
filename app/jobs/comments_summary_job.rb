class CommentsSummaryJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    comments = Comment.where(['created_at = ?', date_summary]).order(:user_id, :post_id)
    
  end
end
