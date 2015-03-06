class SessionsController < ApplicationController
  def new
  end

  def login
  	user = User.authenticate(params[:email], params[:password])
    if user.nil?
  		flash[:error] = "Incorrect email or password."
  		redirect_to root_path
  	else
      session[:current_user_id] = user[:id]
      session[:current_user_name] = user[:first_name]
      session[:current_user_state] = user[:state]
      session[:logged_in] = true
      redirect_to root_path
  	end
  end

  def destroy
    session[:logged_in] = false
    reset_session
  	redirect_to root_path
  end

private

end


