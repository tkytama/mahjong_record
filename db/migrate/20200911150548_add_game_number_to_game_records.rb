class AddGameNumberToGameRecords < ActiveRecord::Migration[5.2]
  def add
    add_column :game_records, :game_number, :integer
    add_column :game_records, :calculation, :boolean
  end
end
