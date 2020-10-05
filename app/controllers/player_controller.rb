class PlayerController < ApplicationController
  def show
    @players = User.where(room_id: params[:room_id])
    @player = @players.find(params[:id])
    @game_records = GameRecord.where(room_id: params[:room_id])
    @player_game_records = GameRecord.where(room_id: params[:room_id]).where(user_id: @player.id)
    @player_rank = @game_records.order(:count).order(point: :desc)
  end


end
