class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @gamerecords = GameRecord.where(user: current_user.id)
    @rooms_number = @gamerecords.pluck(:room_id).uniq
  end

  def point
    @user = User.find(params[:id])
    @gamerecords = GameRecord.where(user: current_user.id)
    @rooms_number = @gamerecords.pluck(:room_id).uniq
    @q = @gamerecords.search(params[:q])
    @gamerecords_user = @q.result
  end

end
