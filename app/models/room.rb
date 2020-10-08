class MochiValidator < ActiveModel::EachValidator
  def validates_each(record,after,value)
    record.errors.add(after,'テスト') if value.include?("25000")
  end
end

class Room < ApplicationRecord
  MAX_TOTAL_POINT = 100000
  has_many :users
  has_many :game_records
  accepts_nested_attributes_for :game_records

  validate :require_total_score

  def require_total_score
    total_point = 0
    game_records
        .select{ |game_record| game_record.calculation == nil }
        .each do |game_records|
          total_point += game_records.point
    end

    errors.add(:base, '合計10万点になっていません') if total_point != MAX_TOTAL_POINT
  end
end
