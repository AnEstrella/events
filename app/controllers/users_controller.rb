class UsersController < ApplicationController
  def new
    @user = User.new
  end

#root path
  def index
    if session[:logged_in]
      @events = Event.joins('LEFT JOIN event_attendees ON events.id = event_attendees.event_id').where("event_attendees.user_id != '#{session[:current_user_id]}'")
      @attending_events = Event.joins('LEFT JOIN event_attendees ON events.id = event_attendees.event_id').where("event_attendees.user_id = '#{session[:current_user_id]}'")  
      @owned_events = Event.all.where("user_id = #{session[:current_user_id]}")
      #events in other states
      @other_events = Event.all.where ("state != '#{session[:current_user_state]}'")
      render '/events/index'
    else
      render 'users/index'
    end
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = 'User was successfully created. Login to continue.'
      redirect_to root_path
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
