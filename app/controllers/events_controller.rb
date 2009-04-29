class EventsController < ApplicationController
  def index
    @events = Event.by_date
  end

  def show
    @event = Event.find(params[:id])
    @users = @event.users
    @friends = current_user.friends_at(@event) if logged_in?
  end
end
