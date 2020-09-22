class GamesController < ApplicationController
  def index
    @game_records = GameRecord.where(room_id: params[:room_id])
    @game_records_now = @game_records.where(calculation: nil)
    @player = @game_records_now.find_by(user_id: current_user.id)
    @player_mine = User.find(current_user.id)

    if @player.seat == "ton"
      other_player("sha", "pe", "nan")
    elsif @player.seat == "nan"
      other_player("pe", "ton", "sha")
    elsif @player.seat == "sha"
      other_player("sha", "nan", "pe")
    else
      other_player("nan", "sha", "ton")
    end
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

  private
 
    def player_direction(direction)
      @game_records_now.find_by(seat: direction)
    end

    def other_player(front, left, right)
      @player_front = User.find(player_direction(front).user_id)
      @player_left = User.find(player_direction(left).user_id)
      @player_right = User.find(player_direction(right).user_id)
    end

end
