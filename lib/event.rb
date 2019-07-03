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



  def edit!( new_name, new_description )
    # Change the object
    @name = new_name
    @description = new_description
  end
end
