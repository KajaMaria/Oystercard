
class Journey
attr_reader :exit_station, :entry_station

def initialize(entry_station = nil, exit_station = nil )
@exit_station = exit_station
@entry_station = entry_station
end

def update_exit_station(station)
  @exit_station = station
end

def journey?
  @entry_station != nil && @exit_station == nil 
end

end
