require 'oystercard'
require 'faker'

describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:oystercard_with_1) { described_class.new(Oystercard::MIN_FAIR) }
  let(:money) { Faker::Number.between(1, 10) }
  let(:station) { double :station }
  describe '#new' do
    it "has no balance when inititialized" do
      expect(oystercard.balance).to eq 0
    end
    it 'has a set max of £90' do
    expect(oystercard.max_balance).to eq Oystercard::DEFAULT_MAX_BALANCE
    end
    it 'raises an error if someone tries to put more than £90' do
      expect { oystercard.top_up(91)}.to raise_error 'Max top up allowed is £90. Please select different amount'
    end

  end
  describe '#top_up' do
    it 'we want a top-up method which allows adding money to balance' do
      expect(oystercard.top_up(money)).to eq (0 + money)
    end
  end
  context '#deduct' do
    xit "deducts money from Users balance" do
      #x before it silence the whole it test
      oystercard.top_up(20)
      expect(oystercard.deduct(5)).to eq 15
    end
  end
  context '#touch_in' do
    it "states that card is in use when true" do
      expect(oystercard_with_1.touch_in(station)).to be true
    end
    it "raises an error when balance is insufficient" do
      # oystercard.top_up(2)
      expect { oystercard.touch_in(station)}.to raise_error 'Balance is insuffcient'
    end
    it "remembers the entry station " do
      expect {oystercard_with_1.touch_in(station)}.to change{oystercard_with_1.entry_station}.to(station)
    end
  end
  context '#touch_out' do
    it "states that card is not in use" do
      expect(oystercard.touch_out).to be false
    end
    it "is going to deduct money from the balance" do
      expect {oystercard_with_1.touch_out}.to change{oystercard_with_1.balance}.by(-1)
    end
  end
  context '#in_journey?' do
    it "says that it is in journey when touched in" do
      oystercard_with_1.touch_in(station)
      expect(oystercard_with_1.in_journey?).to be true
    end
    it "says that it is in journey when touched in" do
      expect(oystercard.in_journey?).to be false
    end
  end
end
