class UsersController < ApplicationController
  def signup
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_path
    else
      render :signup
    end
  end
end
