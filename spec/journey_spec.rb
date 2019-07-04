require 'journey'

describe Journey do
  let(:station) { double :station }
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }
  context '#add_entry_journey' do
    it "Starts a new journey" do
      subject.add_entry_journey(station)
      expect(subject.journey[:begin]).to eq station
    end
  end
  context '#add_exit_station' do
    it "has an exit point" do
      subject.add_exit_station(station)
      expect(subject.journey[:end]).to eq station
    end
  end
  context '#fare' do
    it "returns minimum fare" do
      subject.add_entry_journey(entry_station)
      subject.add_exit_station(exit_station)
      expect(subject.fare(1)).to eq 1
    end
    it 'returns default if no either entry or exit' do
      subject.add_entry_journey(entry_station)
      expect(subject.fare(1)).to eq 6
    end
    it 'returns default if no exit' do
      subject.add_exit_station(exit_station)
      expect(subject.fare(1)).to eq 6
    end
  end


end
