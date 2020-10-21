class AddYakitoriToGameRecords < ActiveRecord::Migration[5.2]
  def change
    add_column :game_records, :yakitori, :boolean
  end
end
