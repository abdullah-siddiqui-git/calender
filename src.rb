require_relative "calender"
require_relative "event"


calender = Calender.new

event = Event.events_factory

event2 = Event.events_factory



calender.register_event! "01-07-2019", event

calender.register_event! "02-07-2019", event2


calender.print_whole_calender


# calender.edit_event! "01-07-2019", 0

# calender.print_whole_calender


# calender.delete_event! "01-07-2019", 0

# calender.print_whole_calender


# calender.print_events_on_date "01-07-2019"


calender.print_events_in_month "07", "2019"
