require 'oystercard'
# In order to use public transport
# As a customer
# I want money on my card
describe Oystercard do
  it 'requires for oystercard to have a balance' do
    oystercard = Oystercard.new
    expect(oystercard.balance).to eq 0
  end
end
