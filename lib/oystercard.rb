require 'money'
require 'pry'
require_relative 'journey.rb'

class Oystercard
   DEFAULT_MAX_BALANCE = 90
   MIN_FAIR = 1

  attr_reader :balance, :max_balance, :money, :journeys, :current_journey

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

#You can only use Journey.new as an argument for RSPEC
  def touch_in(station, journey = Journey.new)
    raise 'Balance is insuffcient' if insufficient?
    @current_journey = journey
    @current_journey.add_entry_journey(station)
  end

  def touch_out(station, journey = Journey.new)
    if @current_journey == nil
      @current_journey = journey
      deduct_and_end(station)
    elsif @current_journey.journey.key?(:begin)
      deduct_and_end(station)
    else
      updated_journey
      @current_journey = journey
      deduct_and_end(station)
    end
  end

# when we access other object with their private methods we cant access them in test! Only original class
  private

  def updated_journey
      @journeys << @current_journey
      @current_journey = nil
  end

  def add_journey(entry_station, exit_station)
    @journeys << Journey.new(entry_station,exit_station)
  end

  def deduct(money)
    @balance -= money
  end

  def deduct_and_end(station)
    @current_journey.add_exit_station(station)
    deduct(@current_journey.fare(MIN_FAIR))
    updated_journey
  end

  def insufficient?
    @balance < MIN_FAIR
  end

  def max(money)
    money + @balance > DEFAULT_MAX_BALANCE
  end
end

# binding.pry
