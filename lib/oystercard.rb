require 'money'
require 'pry'

class Oystercard
   DEFAULT_MAX_BALANCE = 90
   MIN_FAIR = 1

  attr_accessor :balance, :max_balance, :money

  def initialize(balance = 0, max_balance = DEFAULT_MAX_BALANCE, in_use = false)
    @balance = balance
    @max_balance = max_balance
    @in_use = in_use
    # @money = money
  end

  def top_up(money)
    raise 'Max top up allowed is £90. Please select different amount' if max(money) #money + balance > DEFAULT_MAX_BALANCE
    @balance += money
  end

  def touch_in
    raise 'Balance is insuffcient' if insufficient?
    @in_use = true
  end

  def touch_out
    deduct(MIN_FAIR)
    @in_use = false
  end

  def in_journey?
    @in_use
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
