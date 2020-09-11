class CreateGameRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :game_records do |t|
      t.references :user, foreign_key: true
      t.integer :point, length: { maximum: 6 }
      t.string :seat

      t.timestamps
    end
  end
end
