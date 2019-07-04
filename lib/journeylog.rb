require_relative 'journey'

class JourneyLog

  attr_reader :journey

  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @journey = nil
    @journey_log = []
  end

  def start(station)
    @journey = @journey_class.new
    @journey.add_entry_journey(station)
  end

  def finish(station)
    current_journey.add_exit_station(station)
    @journey_log << @journey.journey
  end

  def journeys
    view_journey_log.each do |x|
      x
    end
  end

private

  def view_journey_log
    @journey_log
  end

  def current_journey
    if @journey == nil
      @journey = @journey_class.new
    elsif @journey.journey[:end] != nil
      @journey = @journey_class.new
    else
      return @journey
    end
  end

end



#
# journeylog = JourneyLog.new
# journeylog.start("Whatever")
# journeylog.finish("Trever")
#
# journeylog.finish("Gemma")
# p journeylog.journeys
