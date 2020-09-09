class RoomsController < ApplicationController
  def new
    @room = Room.new
  end

  def create
    conflict_avoidance = 3
    repeat_ten_thousand = 90000
    random_number = rand(10000...99999)

    while Room.find_by(room_key: random_number)
      random_number += conflict_avoidance 
      if random_number >= 100000
        random_number -= repeat_ten_thousand
      end
    end

    @room = Room.new(room_key: random_number,kaeshi: 30000, mochi: 25000, uma_4to1: 10, uma_3to2: 5)
    @room.save
    redirect_to @room, notice: "部屋番号「#{@room.room_key}」に入室しました。"
    
  end

  def show
    @room = Room.find(params[:id])
  end

end
