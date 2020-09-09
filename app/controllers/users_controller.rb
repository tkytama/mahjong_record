class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def point
    @user = User.find(params[:id])
  end

end
