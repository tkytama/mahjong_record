class AddRankToGameRecords < ActiveRecord::Migration[5.2]
  def change
    add_column :game_records, :rank, :integer
    add_column :game_records, :rate, :integer
  end
end
