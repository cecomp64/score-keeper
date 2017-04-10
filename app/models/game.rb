class Game < ActiveRecord::Base
  belongs_to :winner, class_name: 'Player', foreign_key: 'player_id'
  has_and_belongs_to_many :players
  has_many :scores
  belongs_to :user

  validates_presence_of :name, :user_id
end
