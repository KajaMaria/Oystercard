require 'oystercard'
require 'faker'

describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:oystercard_with_1) { described_class.new(Oystercard::MIN_FAIR) }
  let(:money) { Faker::Number.between(1, 10) }
  let(:station) { double :station }
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }
  let(:journey_fine) { double :journey, :add_entry_journey => nil, :add_exit_station => nil, :fare => 1 }
  let(:journey_with_penalty) { double :journey, :add_entry_journey => nil, :add_exit_station => nil, :fare => 6 }

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

      oystercard_with_1.touch_in(station, journey_fine)
      expect(oystercard_with_1.current_journey).to eq journey_fine
    end
  end
  context '#touch_out' do
    it "is going to deduct money from the balance" do
      oystercard_with_1.touch_out(exit_station, journey_fine)
      expect(oystercard_with_1.balance).to eq 0
    end
    it "is going to deduct money if no entry was added to this journey " do
      oystercard_with_1.touch_out(exit_station, journey_with_penalty)
      expect(oystercard_with_1.balance).to eq -5
    end
  end 

end
