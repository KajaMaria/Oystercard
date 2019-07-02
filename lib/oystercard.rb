require 'money'
require 'pry'
require_relative 'journey.rb'

class Oystercard
   DEFAULT_MAX_BALANCE = 90
   MIN_FAIR = 1

  attr_reader :balance, :max_balance, :money, :journeys

  def initialize(balance = 0, max_balance = DEFAULT_MAX_BALANCE)
    @balance = balance
    @max_balance = max_balance
    @journeys = []


    # @money = money
  end

  def top_up(money)
    raise 'Max top up allowed is £90. Please select different amount' if max(money) #money + balance > DEFAULT_MAX_BALANCE
    @balance += money
  end

  def touch_in(entry_station)
    raise 'Balance is insuffcient' if insufficient?
    add_journey(entry_station, nil)
  end

  def touch_out(exit_station)
    if @journeys.length > 0
    @journeys.last.update_exit_station(exit_station)
    else
    add_journey(nil,exit_station)
    end

    deduct(MIN_FAIR)
  end

  def in_journey?
    return @journeys.last.journey? if @journeys.length > 0
    false
  end


# when we access other object with their private methods we cant access them in test! Only original class
  private

  def add_journey(entry_station, exit_station)
    @journeys << Journey.new(entry_station,exit_station)
  end

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
