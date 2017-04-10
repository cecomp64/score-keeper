class Player < ActiveRecord::Base
  has_and_belongs_to_many :games
  has_many :scores

  validates :name, uniqueness: {scope: :user_id, case_sensitive: false}
  validates_presence_of :name, :user_id
end
