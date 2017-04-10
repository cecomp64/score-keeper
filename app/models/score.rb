class Score < ActiveRecord::Base
  belongs_to :player
  belongs_to :game

  validates_presence_of :name, :user_id
end
