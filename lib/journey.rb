
class Journey
  attr_reader :journey

  def initialize
    @journey = {}
    @finished_journey = false


    # @exit_station = exit_station
    # @entry_station = entry_station
  end

  def add_entry_journey(entry_station)
    @journey[:begin] = entry_station
  end

  def add_exit_station(exit_station)
    @journey[:end] = exit_station
    @finished_journey = true if completed?
    @journey[:finished] = @finished_journey
  end

  def fare
    if completed?
      return count_fare
    else 
      return Oystercard::PENALTY
    end
  end

private

  def completed?
    @journey[:begin] != nil && @journey[:end] != nil
  end

  def count_fare
    starting_zone = @journey[:begin].zone
    ending_zone = @journey[:end].zone
    fare =Oystercard::MIN_FAIR + (starting_zone - ending_zone).abs
  end

end

# new_journey = Journey.new
# new_journey.add_entry_journey("whatever")
# new_journey.add_exit_station("trever")
# p new_journey.journey
