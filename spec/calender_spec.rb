require './lib/calender'
require './lib/event'

describe Calender do 
  let( :calender ) { Calender.new }

  it "registers events in calender" do
    event = Event.new( "Event 1", "Event 1 description." )
    date  = Date.new( 2019, 7, 2 )

    calender.register_event! date, event 

    # Check if the last added event on the day matches to the object we 
    # have just created in the above code.
    expect( calender.get_list_of_events( date )[ -1 ] ).to equal( event )
  end

  it "Edit the registered event" do 
    # Add a new event and check if changes
    event = Event.new( "Event 1", "Event 1 description." )
    date  = Date.new( 2019, 7, 2 )

    calender.register_event! date, event

    # Edit event and check for the change after editing
    # -1 is given as the index of event as the added event will be present at
    # the end of the array.
    calender.edit_event!( date, -1, "Event 1 - changed", "Event 1 description - changed" )

    # At this point of code, event must be changed.
    expect( calender.get_list_of_events( date )[ -1 ].name ).to eq( "Event 1 - changed" )
  end

  it "Check if deletion works properly" do
    # Add a new event and check if changes
    event = Event.new( "Event 1", "Event 1 description." )
    date  = Date.new( 2019, 7, 2 )

    calender.register_event! date, event

    # Delete this event from the calender and try to search it again.
    # Added event will be present at the end of the array.
    # -1 as index refers to the end of the array. 
    calender.delete_event!( date, -1 )

    # Check if the event object is still present in the list of events.
    result = calender.get_list_of_events( date ).select { |event_loop| event_loop.object_id == event.object_id }
    expect( result.length ).to eq( 0 )
  end
end