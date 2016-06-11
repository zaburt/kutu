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
  after_destroy :notify_destroy
  after_update :notify_update

  belongs_to :game
  belongs_to :user

  validates_presence_of :user_id, :game_id

  private

  def notify_new
    KutuMailer.game_comment_new(self).deliver
  end

  def notify_destroy
    KutuMailer.game_comment_destroy(self).deliver
  end

  def notify_update
    KutuMailer.game_comment_update(self).deliver if self.changes.present?
  end
end
