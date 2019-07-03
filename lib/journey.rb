
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

  end

  def fare(minimum)
    return minimum if completed?
    return 6
  end

private

  def completed?
    @journey[:begin] != nil && @journey[:end] != nil
  end


end

# new_journey = Journey.new
# new_journey.add_entry_journey("whatever")
# p new_journey.journey
