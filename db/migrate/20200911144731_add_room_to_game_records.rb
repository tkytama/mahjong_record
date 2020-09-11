class AddRoomToGameRecords < ActiveRecord::Migration[5.2]
  def change
    add_reference :game_records, :room, foreign_key: true
  end
end
