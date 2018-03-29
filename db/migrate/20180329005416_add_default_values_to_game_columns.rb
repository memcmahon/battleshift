class AddDefaultValuesToGameColumns < ActiveRecord::Migration[5.1]
  def change
    change_column :games, :player_1_turns, :integer, default: 0
    change_column :games, :player_2_turns, :integer, default: 0
    change_column :games, :current_turn, :integer, default: 0
  end
end
