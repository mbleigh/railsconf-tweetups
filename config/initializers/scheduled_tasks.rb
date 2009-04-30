scheduler = Rufus::Scheduler.start_new

scheduler.every "10m" do
  User.all.each{|u| u.refresh_friendships! if u.updated_at < 10.minutes.ago }
  RAILS_DEFAULT_LOGGER.info ' - Successfully refreshed user relationships'
end
