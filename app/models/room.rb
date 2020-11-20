class Room < ApplicationRecord
  TOTAL_POINT = 100000
  has_many :users
  has_many :game_records
  accepts_nested_attributes_for :game_records
  
  validate :require_total_point
  validate :require_player_seat
  validate :require_total_rate

  def require_total_point
    total_point = 0
    if game_records[0] != nil
      game_records
        .select{ |game_record| game_record.calculation == nil }
        .each do |game_records|
        total_point += game_records.point
      end
    else
      total_point = TOTAL_POINT
    end

    errors.add(:base, '合計得点が10万点になっていません') if total_point != TOTAL_POINT
  end

  def require_player_seat
    count_ton = 0
    count_nan = 0
    count_sha = 0
    count_pe = 0
    if game_records[0] != nil
      game_records
        .select{ |game_record| game_record.calculation == nil }
        .each do |game_records|
        if game_records.seat == "ton"
          count_ton += 1
        elsif game_records.seat == "nan"
          count_nan += 1
        elsif game_records.seat == "sha"
   	  count_sha += 1
        else
  	  count_pe += 1
        end
      end
    else
      count_ton = 1
      count_nan = 1
      count_sha = 1
      count_pe = 1
    end
    
    errors.add(:base, '東、南、西、北を一回ずつ入力してください') if count_nan == 0 || count_ton == 0 || count_sha == 0 || count_pe == 0
  end
  
  def require_total_rate
    total_rate = 0
    game_records
      .select{ |game_record| game_record.calculation == nil }
      .each do |game_records|
      total_rate += game_records.rate
    end
    errors.add(:base, 'レートの合計が0になるように点数を調整してください') if total_rate != 0
  end
end
