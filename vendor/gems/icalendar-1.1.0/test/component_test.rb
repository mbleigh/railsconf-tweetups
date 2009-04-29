$:.unshift File.join(File.dirname(__FILE__), "..", "lib")

require 'date'
require 'test/unit'
require 'icalendar'

class TestComponent < Test::Unit::TestCase

  # Create a calendar with an event for each test.
  def setup
    @cal = Icalendar::Calendar.new
    @event = Icalendar::Event.new
  end

  def test_add_remove_component
    @cal.add_component(@event)
    assert_equal(1, @cal.events.size)
    @cal.remove_component(@event)
    assert_equal(0, @cal.events.size)
  end

  def test_ical_property
    # No alias but it does have a prop_name
    assert_equal(false, @event.ip_class?)
    @event.ip_class = "PRIVATE"
    assert_equal(true, @event.ip_class?)
    assert_equal("PRIVATE", @event.ip_class)

    # Check that both dtend and its alias start work correctly
    date = DateTime.new(2005, 02, 05, 23, 24, 25)
    @event.dtend = date
    assert_equal(date.year, @event.dtend.year)

    date2 =  DateTime.new(2005, 02, 05, 23, 24, 26)
    @event.end = date2
    assert_equal(date2.year, @event.end.year)
  end

  def test_ical_multi_property
    # Query
    assert_equal(false, @event.comments?)
    @event.comments = []
    assert_equal(true, @event.comments?)

    # Should return an empty array, rather than nil
    assert_equal(0, @event.comments.size)

    # Add and remove
    @event.add_comment "c1"
    @event.add_comment "c2"
    assert_equal(2, @event.comments.size)
    assert_equal(["c1","c2"], @event.comments)
    @event.remove_comment "c1"
    assert_equal(["c2"], @event.comments)

    # Set & get whole array
    foo = ["as", "df"]
    @event.comments = foo
    assert_equal(foo, @event.comments)
  end

  def test_x_property
    @event.x_foobar = "my-custom-property"
    assert_equal("my-custom-property", @event.x_foobar)
  end
end
