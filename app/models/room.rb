class Room < ApplicationRecord
  has_many :users
  has_many :game_records
  accepts_nested_attributes_for :game_records
end
