class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :round
      t.integer :player_id
      t.integer :game_id
      t.float :score

      t.timestamps
    end
  end
end
