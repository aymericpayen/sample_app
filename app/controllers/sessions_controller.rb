class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
     log_in user
     redirect_to user
    else
      #using flash.now avoid displaying the :danger when reloading or loading new page after wrong credentials
      flash.now[:danger]= "Invalid email and/or password"
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

end
