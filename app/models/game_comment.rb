# == Schema Information
#
# Table name: game_comments
#
#  id         :integer          not null, primary key
#  comment    :text
#  game_id    :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_game_comments_on_game_id  (game_id)
#  index_game_comments_on_user_id  (user_id)
#

class GameComment < ActiveRecord::Base

  after_create :notify_new

  belongs_to :game
  belongs_to :user

  validates_presence_of :user_id, :game_id

  private

  def notify_new
    KutuMailer.game_comment_new(self).deliver
  end
end
