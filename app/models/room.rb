class MochiValidator < ActiveModel::EachValidator
  def validates_each(record,after,value)
    record.errors.add(after,'テスト') if value.include?("25000")
  end
end

class Room < ApplicationRecord
  has_many :users
  has_many :game_records
  accepts_nested_attributes_for :game_records
  
  validates :mochi, mochi: true

end
