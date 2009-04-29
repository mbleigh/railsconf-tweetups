require 'open-uri'

class UsersController < ApplicationController
  before_filter :login_required, :only => [:home, :fetch_schedule]
  def home
    @events = current_user.events.by_date 
    @friends = current_user.friends
  end

  def fetch_schedule
    fetch_url = params[:fetch_url]
    flash[:error] = "You must provide a RailsConf schedule URL. No others will be accepted." and redirect_to :back and return unless URI.parse(fetch_url).host == 'en.oreilly.com'

    current_user.attendances.destroy_all
    calendar = Icalendar.parse(open(fetch_url).read).first
    
    calendar.events.each do |ical_event|
      event = Event.create_from_ical(ical_event)
      current_user.events << event
    end

    flash[:notice] = "Successfully imported RailsConf schedule."
    redirect_to home_path
  end

  def show
    @user = User.find_by_login(params[:id])
    @events = @user.events.by_date
  end
end
