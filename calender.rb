class Calender

  def initialize
    @events = {}
  end

  def print_whole_calender
    puts @events
  end

  def register_event!( date_string, event )
     # Parse Date
     # It is expected to be in the format dd-mm-yyyy

     # Split date on "-"
     date, month, year = date_string.split( "-" )

     # Check if events has keys related to date, month, year

     # Check existence for year key
     unless @events.has_key? year
      @events[ year ] = {}
     end

     # Check existence for month key
     unless @events[ year ].has_key? month
      @events[ year ][ month ] = {}
     end

     # Check existence for date key
     unless @events[ year ][ month ].has_key? date
      @events[ year ][ month ][ date ] = []
     end

     # Now append event object to the end of the array we just created, if
     # already not, being pointed by the date in @events hash.

     puts "Creating event at date #{date_string}"
     @events[ year ][ month ][ date ].push event
  end


  def edit_event!( date_string, event_num )
    # Parse Date
    # It is expected to be in the format dd-mm-yyyy

    # Split date on "-"
    date, month, year = date_string.split( "-" )

    # Get Event object
    event = @events[ year ][ month ][ date ][ event_num ]

    # Edit this event
    event.edit!

    puts "Editing done!"
  end


  def delete_event!( date_string, event_num )
    # Parse Date
    # It is expected to be in the format dd-mm-yyyy

    # Split date on "-"
    date, month, year = date_string.split( "-" )

    # Delete Event object.
    @events[ year ][ month ][ date ].slice! event_num 

    # Remove the allocated memory from calender hash if no events are present in 
    # hash location pointed by the date of event

    # Check if there is no other event at given date
    if @events[ year ][ month ][ date ].empty?
      # Delete if hash entry is there is no other event
      @events[ year ][ month ].delete  date
    end

    # Check if there is no other event in the specified month
    if @events[ year ][ month ].size == 0
      # Delete if current month has no other event
      @events[ year ].delete month
    end

    # Check if there is no other event in the specified year
    if @events[ year ].size == 0
      # Delete if current year has no other event
      @events.delete year
    end


    puts "Deletion done!"
  end

  def print_events_on_date( date_string )
    # Parse Date
    # It is expected to be in the format dd-mm-yyyy

    # Split date on "-"
    date, month, year = date_string.split( "-" )

    @events[ year ][ month ][ date ].each_with_index do | event, index |
      puts "-------- #{index + 1} ---------"
      event.print_detail
    end
  end

  def print_events_in_month( month, year )
    puts "========= #{month} - Month =========="

    @events[ year ][ month ].each do | key, value | 

      # Print day of month
      # Here, key will be day of month 
      puts "********* #{key} - Day of Month *********"

      # Here, value will be an array containing events
      # Loop through value array to get events and print them
      value.each_with_index do | event, index |
        puts "-------- #{index + 1} ---------"
        event.print_detail                  
      end

    end
  end

end