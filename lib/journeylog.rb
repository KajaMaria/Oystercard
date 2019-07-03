require 'journey'

class JourneyLog

  attr_reader :journey

  def start(station, journey = Journey.new)
    @journey = journey
    @journey.add_entry_journey(station)
  end

end
