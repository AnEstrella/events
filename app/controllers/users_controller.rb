class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def index

  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render 'events/index', notice: 'User was successfully created.'
    else
      flash[:error] = @user.errors.full_messages
      redirect_to root_path
    end
  end

  def update
  end

private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :city, :state, :password, :password_confirmation)
  end

end
