require 'journey'

describe Journey do
  let(:station) { double :station }
  let(:station_with_zone) { double :station_with_zone, :name => "Victoria", zone: 1 }
  let(:station_with_zone_exit) { double :station_with_zone, :name => "Mile end", zone: 3 }
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
      subject.add_entry_journey(station_with_zone)
      subject.add_exit_station(station_with_zone_exit)
      expect(subject.fare).to eq 3
    end
    it 'returns default if no either entry or exit' do
      subject.add_entry_journey(entry_station)
      expect(subject.fare).to eq 6
    end
    it 'returns default if no exit' do
      subject.add_exit_station(exit_station)
      expect(subject.fare).to eq 6
    end
  end


end
