class GamesController < ApplicationController
  def index
    @players = User.where(room_id: params[:room_id])
  end

  def show
  end

  def new
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
