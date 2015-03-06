class EventsController < ApplicationController
  def index
    if session[:logged_in]
      render 'events/index'
    else
      redirect_to root_path
    end

  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:notice] = "Your event has successfully been created!"
      redirect_to root_path
    else
      flash[:error] = @event.errors.full_messages
      redirect_to root_path
    end
  end

  def attend
    joined_event = EventAttendee.create(user_id: session[:current_user_id], event_id: params[:id])
    redirect_to root_path
  end 

  def cancel
    left_event = EventAttendee.delete_all("event_attendees.event_id = #{params[:id]} AND event_attendees.user_id = #{session[:current_user_id]}")
    redirect_to root_path
  end

  def edit
  end

  def destroy
    deleted_event = Event.find(params[:id]).delete
    redirect_to root_path
  end

  def show
  end

private
  def event_params
    params.require(:event).permit(:name, :date, :location, :state, :user_id)
  end
end
