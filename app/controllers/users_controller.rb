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

  def authenticate
    session[:logged_in] = true   
    flash[:notice] = "#{params[:username]} is logged in"
    redirect_to root_path
  end
end
