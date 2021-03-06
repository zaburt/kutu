# == Schema Information
#
# Table name: games
#
#  id               :integer          not null, primary key
#  name             :string
#  address          :text
#  city_id          :integer
#  game_category_id :integer
#  house_id         :integer
#  phone            :string
#  email            :string
#  website          :string
#  facebook         :string
#  twitter          :string
#  instagram        :string
#  lat              :float
#  lng              :float
#  story            :text
#  game_times       :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  slug             :string
#  active           :boolean          default(TRUE)
#  publish          :boolean          default(FALSE)
#
# Indexes
#
#  index_games_on_city_id           (city_id)
#  index_games_on_game_category_id  (game_category_id)
#  index_games_on_house_id          (house_id)
#  index_games_on_slug              (slug) UNIQUE
#

class Game < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged

  after_create :notify_new
  after_destroy :notify_destroy
  after_update :notify_update


  belongs_to :city
  belongs_to :game_category
  belongs_to :house

  has_many :game_comments, -> {order(:created_at)}
  has_many :game_labels_games
  has_many :game_labels, -> {order(:name)}, :through => :game_labels_games, :dependent => :destroy

  validates_presence_of :name

  scope :active, -> {where(:active => true)}
  scope :publishable, -> { where(:publish => true) }
  scope :include_unpublished, ->(should_include) { publishable unless should_include}
  scope :for_house, -> (house) {
    if house.is_a?(House)
      where(:house_id => house.id)
    else
      where(:house_id => house)
    end
  }

  # force friendly_id to update slug
  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end

  private

  def notify_new
    KutuMailer.game_new(self).deliver
  end

  def notify_destroy
    KutuMailer.game_destroy(self).deliver
  end

  def notify_update
    KutuMailer.game_update(self).deliver if self.changes.present?
  end
end

