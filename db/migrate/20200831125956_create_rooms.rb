class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.string :room_key, length: { is: 4 }, null: false
      t.integer :kaeshi, length: { maximum: 5 }, null: false
      t.integer :mochi, length: { maximum: 5 }, null: false
      t.integer :uma_4to1, length: { maximum: 2 }, null: false
      t.integer :uma_3to2, length: { maximum: 2 }, null: false
      t.integer :tobi, length: { maximum: 2 }
      t.integer :rate, length: { maximum: 3 }
      t.integer :yakitori, length: { maximum: 2 }
      t.boolean :kuitan
      t.boolean :atoduke

      t.timestamps
    end
  end
end
