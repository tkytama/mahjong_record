class LogoutController < ApplicationController
 
  def destroy
    @room = Room.find(params[:room_id])
    @game_records = GameRecord.where(room_id: params[:room_id])
    @game_records_now = @game_records.where(calculation: nil)
    @count = @game_records_now[0].count
    
    @game_records_now.each do |game_record|
      game_record.destroy
    end

    @game_records.pluck(:user_id).uniq.each do |player|
      user = User.find(player)
      user.room_id = nil
      user.save
    end
    @room.room_key = nil
    @room.save
    redirect_to user_path(id: current_user.id)
    
  end

  def edit
    @room = Room.find(params[:room_id])
    @game_records = GameRecord.where(room_id: params[:room_id])
    @game_records_now = @game_records.where(calculation: nil)
    @count = @game_records_now[0].count
    @yakitori_count = @game_records_now.pluck(:yakitori).count(true)
  end

  def update
    @room = Room.find(params[:room_id])
    @game_records = GameRecord.where(room_id: params[:room_id])
    @game_records_now = @game_records.where(calculation: nil)
    @count = @game_records_now[0].count

    if @room.update(update_room_params)
      @game_records_now.each do |game_record|
        game_record.user.room_id = nil
        game_record.save
        game_record.destroy
      end
      redirect_to user_path
    end
  end

  def index
    @room = Room.find(params[:room_id])
    @game_records = GameRecord.where(room_id: params[:room_id])
    @game_records_now = @game_records.where(calculation: nil)
    @count = @game_records_now[0].count
    @yakitori_count = @game_records_now.pluck(:yakitori).count(true)

  end

  def confirm_tobi_yakitori
    @room = Room.find(params[:room_id])
    @game_records = GameRecord.where(room_id: params[:room_id])
    @game_records_now = @game_records.where(calculation: nil)
    @count = @game_records_now[0].count
    @yakitori_count = @game_records_now.pluck(:yakitori).count(true)

    @player = @game_records_now.find_by(user_id: current_user.id)
    @player_mine = User.find(current_user.id)

    if @player.seat == "ton"
      other_player("sha", "pe", "nan")
    elsif @player.seat == "nan"
      other_player("pe", "ton", "sha")
    elsif @player.seat == "sha"
      other_player("ton", "nan", "pe")
    else
      other_player("nan", "sha", "ton")
    end

    if @room.yakitori
      if @front_seat.yakitori
        @yakitori_player ||= @front_seat.user.name
        if @yakitori_player != nil
           @yakitori_player << "、#{@front_seat.user.name}"
        end
      elsif @left_seat.yakitori
        @yakitori_player ||= @left_seat.user.name
        if @yakitori_player != nil
           @yakitori_player << "、#{@left_seat.user.name}"
        end

      elsif @right_seat.yakitori
        @yakitori_player ||= @right_seat.user.name
        if @yakitori_player != nil
           @yakitori_player << "、#{@right_seat.user.name}"
        end
      else @player.yakitori
        @yakitori_player ||= @player.user.name
        if @yakitori_player != nil
           @yakitori_player << "、#{@player.user.name}"
        end
      end
     end
  end


  def input_tobi_yakitori
    @room = Room.find(params[:room_id])
    @game_records = GameRecord.where(room_id: params[:room_id])
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

    @count = 0
    seats = @room.game_records.pluck(:seat)
    if seats.include?("ton") && seats.include?("nan") && seats.include?("sha") && seats.include?("pe")
      if @room.update(update_room_params)
        redirect_to "/rooms/#{@room.id}/games"
      else
        render 'rooms/game_records'
      end
    end
  end

	
  private

    def player_direction(direction)
      @game_records_now.find_by(seat: direction)
    end

    def update_room_params
      params.require(:room).permit(game_records_attributes: [:point, :seat, :id, :rate])
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
