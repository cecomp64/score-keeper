class GamesPlayersJoinTable < ActiveRecord::Migration
  def change
    create_join_table :games, :players
  end
end
