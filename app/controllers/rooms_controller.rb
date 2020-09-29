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
    user = User.find(current_user.id)
    user.room_id = @room.id
    user.save

    redirect_to @room, notice: "部屋番号「#{@room.room_key}」に入室しました。"
    
  end

  def show
    @room = Room.find(params[:id])
    @users = User.where(room_id: @room.id)
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    @room.update!(room_params)
    redirect_to "/rooms/#{@room.id}/games"
  end

  def game_records

    @game_records = GameRecord.where(room_id: params[:id])
    @game_records_now = @game_records.where(calculation: nil)
    @player_seat = @game_records_now.find_by(user_id: current_user.id)
    @player_mine = User.find(current_user.id)

    if @player_seat.seat == "ton"
      other_player("sha", "pe", "nan")
    elsif @player_seat.seat == "nan"
      other_player("pe", "ton", "sha")
    elsif @player_seat.seat == "sha"
      other_player("ton", "nan", "pe")
    else
      other_player("nan", "sha", "ton")
    end

    @room = Room.find(params[:id])
    @count = 0
  end

  def input_game_records
    @room = Room.find(params[:id])
    seats = @room.game_records.pluck(:seat)
    if seats.include?("ton") && seats.include?("nan") && seats.include?("sha") && seats.include?("pe")
      @room.update(update_room_params)
      redirect_to "/rooms/#{@room.id}/games"
    end
  end



  private

  def room_params
    params.require(:room).permit(:kaeshi, :mochi, :uma_4to1, :uma_3to2, :tobi, :rate, :yakitori, :kuitan, :atoduke)
  end

  def update_room_params
    params.require(:room).permit(game_records_attributes: [:point, :seat, :id])
  end
  
  def player_direction(direction)
    @game_records_now.find_by(seat: direction)
  end

  def other_player(front, left, right)
    @front_seat = player_direction(front)
    @left_seat = player_direction(left)
    @right_seat = player_direction(right)
    @player_front = User.find(player_direction(front).user_id)
    @player_left = User.find(player_direction(left).user_id)
    @player_right = User.find(player_direction(right).user_id)
  end

end
