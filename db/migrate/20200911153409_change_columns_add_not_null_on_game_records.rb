class ChangeColumnsAddNotNullOnGameRecords < ActiveRecord::Migration[5.2]
  def change
    change_column_null :game_records, :game_number, false
  end
end
