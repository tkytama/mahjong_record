class AddRoomIdToUsers < ActiveRecord::Migration[5.2]
  def add
    add_reference :users, :room, foreign_key: true
  end
end
