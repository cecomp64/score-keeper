class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :user_id
      t.integer :player_id
      t.string :name

      t.timestamps
    end
  end
end
