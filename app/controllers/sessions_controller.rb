class SessionsController < ApplicationController
  def new
  end

  def create
    puts user[:email]
  	@user = User.authenticate(login_params[:email], login_params[:password])
  	if @user.nil?
  		flash[:error] = "Incorrect email or password."
  		redirect_to root_path
  	else
  		redirect_to login_path
  	end
  end

  def destroy
  	redirect_to root_path
  end

private
  def login_params
    params.require(:user).permit(:email, :password)
  end
end


