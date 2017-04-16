class Score < ActiveRecord::Base
  belongs_to :player
  belongs_to :game

  validates_presence_of :player, :game, :score, :round
  validates :round, uniqueness: {scope: [:player, :game]}
end
