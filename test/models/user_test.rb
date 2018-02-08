require 'test_helper'

class UserTest < ActiveSupport::TestCase
   def setup
      @u1 = User.new(name: 'ben')
      @u2 = User.new(name: 'toto')
      @u3 = User.new(name: 'yann')
  end

  test 'user creates an event'  do
    e1 = Event.new(description: 'abc')
    e1.creator = @u1
    e1.save
    assert_equal 'ben', e1.creator.name
    assert_equal 'abc', @u1.created_events.first.description
    assert_equal 1, @u1.created_events.size
  end

  test '2 events with 2 attendees'  do
    e1 = Event.new(description: 'abc')
    e1.creator = @u1
    e1.save
    e1.attendees << @u2
    e1.attendees << @u3

    e2 = Event.new(description: 'def')
    e2.creator = @u2
    e2.save
    e2.attendees << @u2
    e2.attendees << @u3

    assert_equal 'abc', @u2.attended_events.first.description
    assert_equal 'def', @u2.attended_events.last.description
    assert_equal 2, @u2.attended_events.size
    assert_equal 2, @u3.attended_events.size
    assert_equal 0, @u1.attended_events.size
  end
end
