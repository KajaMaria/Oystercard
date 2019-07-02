require 'oystercard'
# In order to use public transport
# As a customer
# I want money on my card
describe Oystercard do
  it 'requires for oystercard to have a balance' do
    oystercard = Oystercard.new
    expect(oystercard.balance).to eq 0
  end

  # In order to keep using public transport
  # As a customer
  # I want to add money to my card
  it 'we want a top-up method which allows adding money to balance' do
  oystercard = Oystercard.new
  money = 10
  expect(oystercard.top_up(money)).to eq (0 + money)
end

# In order to protect my money from theft or loss
# As a customer
# I want a maximum limit (of £90) on my card


end
