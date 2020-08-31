class Room < ApplicationRecord
  has_many :users
  has_many :game_records
end
