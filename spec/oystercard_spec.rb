require 'oystercard'
require 'faker'

describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:oystercard_with_1) { described_class.new(Oystercard::MIN_FAIR) }
  let(:money) { Faker::Number.between(1, 10) }
  let(:station) { double :station }
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }
  let(:journey) { double :journey, :add_entry_journey => nil, :add_exit_station => nil }

  let(:current_journey) { instance_double("journey", :entry_station => station, :exit_station => exit_station) }
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
    it 'has an empty journeys storage when initialized' do
      expect(oystercard.journeys).to eq []
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
      it "raises an error when balance is insufficient" do
      # oystercard.top_up(2)
      expect { oystercard.touch_in(station)}.to raise_error 'Balance is insuffcient'
    end
    it "has an entry statiom" do

      oystercard_with_1.touch_in(station, journey)
      expect(oystercard_with_1.current_journey).to eq journey
    end
  end
  context '#touch_out' do
    it "states that card is not in use" do
        expect(oystercard_with_1.in_journey?).to be false
    end
    it "is going to deduct money from the balance" do
      allow(journey).to receive(:update_exit_station)
      expect(oystercard_with_1.touch_out(exit_station)).to eq (0)
    end
    it "is checking if journey is added to journeys storage" do
      oystercard_with_1.touch_in(station)
      allow(journey).to receive(:update_exit_station)
      oystercard_with_1.touch_out(exit_station)
      expect(oystercard_with_1.journeys.length).to eq 1
    end
  end
  context '#in_journey?' do
    it "says that it is in journey when touched in" do
      oystercard_with_1.touch_in(station)
      expect(oystercard_with_1.in_journey?).to be true
    end
    it "says that it is in journey when touched in" do
      allow(journey).to receive(:journey?).and_return false
      expect(oystercard.in_journey?).to be false
    end
  end
end
