class PlayerController < ApplicationController
  def show
    @players = User.where(room_id: params[:room_id])
    @player = @players.find(params[:id])
  end


end
