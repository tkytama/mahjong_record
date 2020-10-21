class AddTobashiToGameRecords < ActiveRecord::Migration[5.2]
  def change
    add_column :game_records, :tobashi, :boolean
  end
end
