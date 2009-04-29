class Event < ActiveRecord::Base
  has_many :attendances, :dependent => :destroy
  has_many :users, :through => :attendances

  named_scope :by_date, :order => :starts_at

  def self.create_from_ical(ical_event)
    if event = find_by_uid(ical_event.uid)
      return event
    else
      create(
        :uid => ical_event.uid,
        :url => ical_event.url,
        :title => ical_event.summary,
        :description => ical_event.description,
        :starts_at => ical_event.dtstart,
        :ends_at => ical_event.dtend,
        :location => ical_event.location
      )
    end
  end
end
