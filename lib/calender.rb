require 'date'
require_relative 'invalid_date_error'

# This class defines calender and what its use cases are.
class Calender
  def initialize
    @events = {}
  end

  def register_event!(date, event)
    # Convert date elements into string in order to use them as keys
    year, month, day = date.year.to_s, date.month.to_s, date.day.to_s

    # Create year key if it is not already present
    @events[year] = {} unless @events.key? year

    # Create month key if it is not already present
    @events[year][month] = {} unless @events[year].key? month

    # Crete day key if it is not already present
    @events[year][month][day] = [] unless @events[year][month].key? day

    # Now append event object to the end of the array we just created, if
    # already not, being pointed by the date in @events hash.
    @events[year][month][day].push event
  end

  def edit_event!(date, event_num, new_name, new_description)
    # Convert date elements into string in order to use them as keys
    year, month, day = date.year.to_s, date.month.to_s, date.day.to_s

    # Get Event object - It generates key error if event is not found.
    event = @events.fetch(year).fetch(month).fetch(day)[event_num]

    # Edit this event
    event.edit!(new_name, new_description)
  end

  def delete_event!(date, event_num)
    # Convert date elements into string in order to use them as keys
    year, month, day = date.year.to_s, date.month.to_s, date.day.to_s

    # Delete event object if it exists.
    # It generates key error if event is not found.
    @events.fetch(year).fetch(month).fetch(day).slice! event_num

    # Remove the allocated memory from calender hash if no events are present in
    # hash location pointed by the date of event

    # Check if there is no other event at given date
    # Delete if hash entry if there is no other event
    @events[year][month].delete day if @events[year][month][day].empty?

    # Check if there is no other event in the specified month
    # Delete if current month has no other event
    @events[year].delete month if @events[year][month].size.zero?

    # Check if there is no other event in the specified year
    # Delete if current year has no other event
    @events.delete year if @events[year].size.zero?
  end

  def print_events_on_date(date)
    # Convert date elements into string in order to use them as keys
    year, month, day = date.year.to_s, date.month.to_s, date.day.to_s

    begin
      @events.fetch(year).fetch(month).fetch(day).each_with_index do |event, index|
        puts "-------- #{index + 1} ---------"
        event.print_detail
      end
    rescue KeyError
      puts 'No event on this day exists.'
    end
  end

  def print_events_in_month(month, year = 2019)
    # Create start of day Date object to keep track of start
    # of the given month
    # Creating Date object also preserves consistency in keys
    # while writing and accessing events in hash of events

    begin
      start_of_month = Date.new(year, month, 1)
    rescue ArgumentError
      raise InvalidDateError.new, 'Wrong month and year given in arguments...'
    end
    year, month = start_of_month.year.to_s, start_of_month.month.to_s

    # Start Print Month
    puts "========= #{start_of_month.strftime('%B')} - Month =========="

    begin
      @events.fetch(year).fetch(month).each do |key, value|
        # Print day of month
        # Here, key will be day of month
        # Make current date
        date_of_events = Date.new(year.to_i, month.to_i, key.to_i)
        formatted_date = date_of_events.strftime('%B %d, %Y - %A')
        puts "********* #{formatted_date} *********"

        # Here, value will be an array containing events
        # Loop through value array to get events and print them
        value.each_with_index do |event, index|
          puts "-------- #{index + 1} ---------"
          event.print_detail
        end
      end
    rescue KeyError
      puts 'No events in this month.'
    end
  end

  def print_in_calender_view(month, year = 2019)
    # To preserve consistency in keys while fetching, we make date object
    # of start and end of the month, and get year and month from it.
    begin
      start_of_month = Date.new(year, month, 1)
      last_day_of_month = Date.new(year, month, -1)
    rescue ArgumentError
      raise InvalidDateError.new, 'Wrong month and year given in arguments...'
    end

    # Set Spaces count between entries
    space_count = 7

    # Print header
    puts 'S      M      T      W      T      F      S'

    # Get Week day of month, 0 for Sunday, and 1 for Monday and 6 for Saturday
    day_of_week = start_of_month.wday

    # Give initial spacing
    (day_of_week * space_count).times { print ' ' }

    # Create temp date object such that it wont be created repeatedly in loop
    current_date_of_month = Date.new(start_of_month.year, start_of_month.month, start_of_month.day)

    # Start printing days
    (1..last_day_of_month.day).each do
      spaces_at_the_end = 7

      # Print an entry
      print_entry_in_calender_view current_date_of_month, spaces_at_the_end

      # Increment day_of_week
      day_of_week += 1

      # Print \n if day_of_week gets to 7
      puts '' if (day_of_week % 7).zero?
      # Next day
      current_date_of_month = current_date_of_month.next
    end

    # Print new line
    puts ''
  end

  def get_list_of_events(date)
    # Convert date elements into string in order to use them as keys
    year, month, day = date.year.to_s, date.month.to_s, date.day.to_s

    # If any key error occurs, this means that no event at that specific day
    # is present
    begin
      @events.fetch(year).fetch(month).fetch(day)
    rescue KeyError
      []
    end
  end

  private

  def print_entry_in_calender_view(current_date_of_month, spaces_at_the_end)
    print current_date_of_month.day.to_s

    # Decrement space count which are to be printed after the complete
    # entry in calender is printed
    spaces_at_the_end -= current_date_of_month.day.to_s.length

    # Get number of events on current date of the month
    num_events = get_num_events_on_date current_date_of_month
    # Make string to be printed
    num_events_string = "[#{num_events}]"
    print num_events_string

    # Decrement space count at the end
    spaces_at_the_end -= num_events_string.length

    # Print spaces
    spaces_at_the_end.times { print ' ' }
  end

  def get_num_events_on_date(date)
    # Convert date elements into string in order to use them as keys
    year, month, day = date.year.to_s, date.month.to_s, date.day.to_s

    # If any key error occurs, this means that no event at that specific day
    # is present
    begin
      num_events = @events.fetch(year).fetch(month).fetch(day).size
      num_events
    rescue KeyError
      0
    end
  end
end
