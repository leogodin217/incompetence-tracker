class UsersController < ApplicationController
  #ssl_required :signup, :login, :create, :authenticate
  skip_before_filter :check_logged_in

  def signup
    @user = User.new
  end

  def login

  end

  def logout
    session[:logged_in] = nil
    redirect_to root_path
  end

  def create
    @user = User.new(params[:user])
	if verify_recaptcha(:model => @user) && @user.save
      flash[:notice] = "New User Created"
      redirect_to root_path
    else
      render :controller => :users, :action => :signup
    end
  end

  def authenticate
    session[:logged_in] = false  
    if @user = User.first(:username => params[:username]) 
   
      if @user.authenticate(:username => params[:username], :password => params[:password]) 
        session[:logged_in] = true 
		session[:logged_in_user] = @user.id
        flash[:notice] = "#{params[:username]} is logged in"

        redirect_to root_path
      else
        flash[:notice] = "Login Failed"
        redirect_to login_path
      end
    else
        flash[:notice] = "Login Failed"
        redirect_to login_path
    
    end
  end
end
