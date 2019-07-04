require 'pry'
require_relative 'journey.rb'
require_relative 'journeylog'

class Oystercard
   DEFAULT_MAX_BALANCE = 90
   MIN_FAIR = 1

  attr_reader :balance, :max_balance, :money, :journeys, :current_journey, :journey_log

  def initialize(balance = 0, journey_log = JourneyLog.new, max_balance = DEFAULT_MAX_BALANCE)
    @balance = balance
    @max_balance = max_balance
    @journeys = []
    @journey_log = journey_log


    # @money = money
  end

  def top_up(money)
    raise 'Max top up allowed is £90. Please select different amount' if max(money) #money + balance > DEFAULT_MAX_BALANCE
    @balance += money
  end

#You can only use Journey.new as an argument for RSPEC
  def touch_in(station)
    raise 'Balance is insuffcient' if insufficient?
    @journey_log.start(station)
  end

  def touch_out(station)
    @journey_log.finish(station)
    deduct(@journey_log.journey.fare(MIN_FAIR))
  end

  def deduct(money)
    @balance -= money
  end

# when we access other object with their private methods we cant access them in test! Only original class
  private

  def add_journey(entry_station, exit_station)
    @journeys << Journey.new(entry_station,exit_station)
  end

  def insufficient?
    @balance < MIN_FAIR
  end

  def max(money)
    money + @balance > DEFAULT_MAX_BALANCE
  end
end

# binding.pry

# oyster = Oystercard.new(10)
# oyster.touch_in("Victoria")
# oyster.touch_out("Aldgate East")
# p oyster.balance
# p oyster.journey_log.journeys
