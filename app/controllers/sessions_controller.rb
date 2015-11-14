class SessionsController < ApplicationController

  def create
    user = User.find_by_email params[:email]
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Loged in"
    else
      flash[:alert] = "Invalid credentials"
      render :new
    end
  end

end
