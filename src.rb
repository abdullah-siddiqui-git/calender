require_relative "calender"
require_relative "event"
require "date"

=begin
  -------------- Methods --------------
=end

def add_event( calender )
  # Add event
  date = get_valid_date_from_user
  event = Event.events_factory

  # Register event
  calender.register_event! date, event

  puts "Successfully created event on #{date.strftime("%B %d, %Y - %A")}"
end


def print_list_of_events( list_of_events )
  list_of_events.each_with_index do | event, index |
    puts "#{index + 1} => #{event.name} - #{event.description}"
  end
end

def get_index_of_event( list_of_events )
  begin
    correct_selection = true

    print "Select an event by entering serial number of that event: "
    selection = gets.to_i
    if selection > list_of_events.size or selection < 1 
      puts "Invalid serial number entered.\nPlease Try again."
      correct_selection = false
    else
      # Return index. 
      # selection - 1 refers to the index of event in array.
      return selection - 1
    end
  end while correct_selection == false
end

def edit_event( calender )
  # Get dates
  date = get_valid_date_from_user

  # Get list of events on a date
  list_of_events = calender.get_list_of_events date

  if list_of_events.length > 0
    # print list of events and get selection from user
    print_list_of_events list_of_events

    # Get index of event from the user
    index_of_event = get_index_of_event list_of_events

    # Edit event
    calender.edit_event! date, index_of_event

    puts "Successfully edited the event!"
  else
    puts "No events are present on this date."
  end
end

 


def delete_event( calender )
  # Get date
  date = get_valid_date_from_user

  # Get list of events on a date
  list_of_events = calender.get_list_of_events date

  if list_of_events.length > 0
    # print list of events and get selection from user
    print_list_of_events list_of_events

    # Get index of event from the user
    index_of_event = get_index_of_event list_of_events

    # Delete event
    calender.delete_event! date, index_of_event 
    
    puts "Successfully deleted the event!" 
  else
    puts "No events are present on this date."
  end
end

def print_calender_view_of_month( calender )
  # Get month number
  print "\nPlease enter month number: (1 - 12)"
  month_num = gets.to_i

  # Get Year
  print "Please enter year: "
  year = gets.to_i

  # print
  calender.print_in_calender_view month_num, year 
end 


def print_details_of_events_on_date( calender )
  # Get date
  date = get_valid_date_from_user

  # print
  calender.print_events_on_date date
end


def print_details_of_events_in_month( calender )
  # Get month number
  print "\nPlease enter month number: (1 - 12)"
  month_num = gets.to_i

  # Get Year
  print "Please enter year: "
  year = gets.to_i

  # print
  calender.print_events_in_month month_num, year
end


def get_valid_date_from_user  
  begin
    correct_date_entered = true
    # Get input
    print "\nGet date in format \" dd-mm-yyyy \" "
    date_string = gets.chomp

    # Parse date
    begin
      date = Date.parse( date_string, "%d-%m-%Y" )
      return date # Return date
    rescue ArgumentError => date_parse_error
      puts %Q(Please enter a valid date. 
      Following could be the causes of errors:
        - Wrong format
        - Date doesn't exist
      )
      correct_date_entered = false
    end
  end while correct_date_entered == false
end


=begin
  -------------- Script starts from here --------------
=end
calender = Calender.new

MENU_ITEMS = 6

menu_string = %Q(\n======= Calender App ========
Menu:
  1 - Add Event
  2 - Edit Event
  3 - Delete Event
  4 - Print calender view of a given month
  5 - Print details of events on a specific date
  6 - Print details of all events in a specified month
)

loop do
  puts menu_string

  begin
    correct_selection = true

    # Print new line and horizontal line
    print "\n-------------------------------------\n"

    # Get user selection
    print "Whats your selection: (1 - #{MENU_ITEMS}): "
    selection = gets.to_i

    case selection
    when 1
      add_event calender

    when 2
      # Edit event
      edit_event calender

    when 3
      # Delete event
      delete_event calender

    when 4
      # Calender view of a month
      print_calender_view_of_month calender

    when 5
      # Print details of events on a specific date
      print_details_of_events_on_date calender

    when 6
      # Print details of events in a specified month
      print_details_of_events_in_month calender 

    else
      puts "Your selection doesn't match any menu item number. Please try again."
      correct_selection = false
    end
    
  end while correct_selection == false 



  print "\nPress enter to print menu again..."
  gets 
end