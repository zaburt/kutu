class Article < ActiveRecord::Base
  belongs_to :game
  belongs_to :picture
end
