class EnterRoomsController < ApplicationController

  def new
  end

  def create
    @room = Room.find_by(room_key: room_params[:room_key])
    user = User.find(current_user.id)
    players = User.where(room_id: @room.id)
    if players.count < 4 && players.select(:user_id) != current_user.id
      user.room_id = @room.id
      user.save
        if players.count == 4
          player1 = GameRecord.new(user_id: players[0].id ,room_id: @room.id ,game_number:1, point: 25000, seat: "ton")
          player2 = GameRecord.new(user_id: players[1].id ,room_id: @room.id ,game_number:1, point: 25000, seat: "nan")
          player3 = GameRecord.new(user_id: players[2].id ,room_id: @room.id ,game_number:1, point: 25000, seat: "sha")
          player4 = GameRecord.new(user_id: players[3].id ,room_id: @room.id ,game_number:1, point: 25000, seat: "pe")
          player1.save
          player2.save
          player3.save
          player4.save
        end
      redirect_to controller: :rooms, action: :show, id: @room.id 
    end

  end

  private

  def room_params
    params.permit(:room_key)
  end



end
