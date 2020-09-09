class EnterRoomsController < ApplicationController

  def new
  end

  def create
    @room = Room.find_by(room_key: room_params[:room_key])
    redirect_to controller: :rooms, action: :show, id: @room.id 
    

  end

  private

  def room_params
    params.permit(:room_key)
  end



end
