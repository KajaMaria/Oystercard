require 'money'
require 'pry'

class Oystercard
   DEFAULT_MAX_BALANCE = 90
   MIN_FAIR = 1

  attr_reader :balance, :max_balance, :money, :entry_station, :journeys

  def initialize(balance = 0, max_balance = DEFAULT_MAX_BALANCE, entry_station = nil)
    @entry_station = entry_station
    @balance = balance
    @max_balance = max_balance
    @journeys = []


    # @money = money
  end

  def top_up(money)
    raise 'Max top up allowed is £90. Please select different amount' if max(money) #money + balance > DEFAULT_MAX_BALANCE
    @balance += money
  end

  def touch_in(station)
    raise 'Balance is insuffcient' if insufficient?
    @entry_station = station
  end

  def touch_out(exit_station)
    @journeys << {:entry_station => @entry_station, :exit_station => exit_station}
    deduct(MIN_FAIR)

  end

  def in_journey?
    @entry_station != nil
  end

  private

  def deduct(money)
    @balance -= money
  end

  def insufficient?
    @balance < MIN_FAIR
  end

  def max(money)
    money + @balance > DEFAULT_MAX_BALANCE
  end
end

# binding.pry
