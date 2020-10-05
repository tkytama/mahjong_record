class AddCountToGameRecords < ActiveRecord::Migration[5.2]
  def change
    add_column :game_records, :count, :integer
  end
end
