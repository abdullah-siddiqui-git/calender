require_relative 'calender'
require_relative 'event'
require 'date'

# ------------------------------------------
#               HELPER METHODS
# ------------------------------------------

def input_event_attributes_from_user
  # Input event name
  puts 'Please enter a valid name for the event: '
  event_name = gets.chomp

  # Input event description
  puts 'Please enter a valid description for the event: '
  event_description = gets.chomp

  return event_name, event_description
end

def print_list_of_events(list_of_events)
  list_of_events.each_with_index do |event, index|
    puts "#{index + 1} => #{event.name} - #{event.description}"
  end
end

def input_index_of_event_from_user(list_of_events)
  loop do
    correct_selection = true

    print 'Select an event by entering serial number of that event: '
    selection = gets.to_i
    if selection > list_of_events.size || selection < 1
      puts "Invalid serial number entered.\nPlease Try again."
      correct_selection = false
    else
      # Return index.
      # selection - 1 refers to the index of event in array.
      return selection - 1
    end

    # Break the loop if correct is correct
    break if correct_selection
  end
end

def input_valid_date_from_user
  loop do
    correct_date_entered = true
    # Get input
    print "\nGet date in format \" dd-mm-yyyy \" "
    date_string = gets.chomp

    # Parse date
    begin
      date = Date.parse(date_string, '%d-%m-%Y')
      return date # Return date
    rescue ArgumentError
      puts 'Please enter a valid date.
      Following could be the causes of errors:
        - Wrong format
        - Date does not exist
      )'
      correct_date_entered = false
    end

    break if correct_date_entered
  end
end

# ------------------------------------------
#       METHODS IMPLEMENTING USE CASES
# ------------------------------------------

def add_event(calender)
  # Add event
  date = input_valid_date_from_user
  event_name, event_description = input_event_attributes_from_user
  event = Event.new(event_name, event_description)

  # Register event
  calender.register_event! date, event

  puts "Successfully created event on #{date.strftime('%B %d, %Y - %A')}"
end

def edit_event(calender)
  # Get dates
  date = input_valid_date_from_user

  # Get list of events on a date
  list_of_events = calender.get_list_of_events date

  if !list_of_events.empty?
    # print list of events and get selection from user
    print_list_of_events list_of_events

    # Get index of event from the user
    index_of_event = input_index_of_event_from_user list_of_events

    # Get new name and new description
    new_name, new_description = input_event_attributes_from_user

    # Edit event
    calender.edit_event! date, index_of_event, new_name, new_description

    puts 'Successfully edited the event!'
  else
    puts 'No events are present on this date.'
  end
end

def delete_event(calender)
  # Get date
  date = input_valid_date_from_user

  # Get list of events on a date
  list_of_events = calender.get_list_of_events date

  if !list_of_events.empty?
    # print list of events and get selection from user
    print_list_of_events list_of_events

    # Get index of event from the user
    index_of_event = input_index_of_event_from_user list_of_events

    # Delete event
    calender.delete_event! date, index_of_event

    puts 'Successfully deleted the event!'
  else
    puts 'No events are present on this date.'
  end
end

def print_calender_view_of_month(calender)
  # Get month number
  print "\nPlease enter month number: (1 - 12) "
  month_num = gets.to_i

  # Get Year
  print 'Please enter year: '
  year = gets.to_i

  # print
  begin
    calender.print_in_calender_view month_num, year
  rescue InvalidDateError => e
    puts e
  end
end

def print_details_of_events_on_date(calender)
  # Get date
  date = input_valid_date_from_user

  # print
  calender.print_events_on_date date
end

def print_details_of_events_in_month(calender)
  # Get month number
  print "\nPlease enter month number: (1 - 12) "
  month_num = gets.to_i

  # Get Year
  print 'Please enter year: '
  year = gets.to_i

  # print
  begin
    calender.print_events_in_month month_num, year
  rescue InvalidDateError => e
    puts e
  end
end

# ------------------------------------------
#          SCRIPT STARTS FROM HERE
# ------------------------------------------

calender = Calender.new

MENU_ITEMS = 6

menu_string = '======= Calender App ========
Menu:
  1 - Add Event
  2 - Edit Event
  3 - Delete Event
  4 - Print calender view of a given month
  5 - Print details of events on a specific date
  6 - Print details of all events in a specified month
'

loop do
  puts menu_string

  loop do
    correct_selection = true

    # Print new line and horizontal line
    print "-------------------------------------\n"

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

    break if correct_selection
  end

  print "\nPress enter to print menu again..."
  gets
end
