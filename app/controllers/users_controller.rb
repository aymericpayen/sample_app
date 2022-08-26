class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    #debugger
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      #flash is hash an empty hash taking a key a value setup by programmer
      flash[:success] = "Signup completed, Welcome to the Sample App"
      redirect_to user_url(@user)  # = @user
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name,:email,:password,:password_confirmation)
    end
end
