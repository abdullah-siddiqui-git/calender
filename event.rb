class Event
  @@id = 0 # Auto incrementing
  attr_accessor :name, :description

  def initialize( name, description )
    @id = @@id
    @name = name
    @description = description

    # Increment @@id to keep it unique
    @@id += 1
  end

  def print_detail
    puts "Name: #{@name}"
    puts "Description: #{@description}"
  end

  def edit!
    # Input events new name
    puts "Please enter a new name for this event: "
    new_name = gets

    # Input events new description
    puts "Please enter new description for this event: "
    new_description = gets

    # Change the object
    @name = new_name
    @description = new_description
  end

  def self.events_factory

    # Input event name
    puts "Please enter a valid name for the event: "
    event_name = gets

    # Input event description
    puts "Please enter a valid description for the event: "
    event_description = gets

    # Create and return new event object.
    Event.new( event_name, event_description )

  end

end