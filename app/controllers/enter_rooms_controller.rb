class EnterRoomsController < ApplicationController

  def new
  end

  def create
    @room = Room.find_by(room_key: room_params[:room_key])
    user = User.find(current_user.id)
    users = User.where(room_id: @room.id)
    if users.count < 4 && users.select(:user_id) != current_user.id 
      user.room_id = @room.id
      user.save
      redirect_to controller: :rooms, action: :show, id: @room.id 
    end

  end

  private

  def room_params
    params.permit(:room_key)
  end



end
