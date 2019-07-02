require 'money'
require 'pry'

class Oystercard
   DEFAULT_MAX_BALANCE = 90

  attr_accessor :balance, :max_balance, :money

  def initialize(balance = 0, max_balance = DEFAULT_MAX_BALANCE)
    @balance = balance
    @max_balance = max_balance
    # @money = money
  end

  def top_up(money)
    raise 'Max top up allowed is £90. Please select different amount' if max(money) #money + balance > DEFAULT_MAX_BALANCE
    @balance += money
  end

  private

  def max(money)
    money + @balance > DEFAULT_MAX_BALANCE
  end
end

binding.pry
