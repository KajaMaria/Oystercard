require 'journey'

describe Journey do
  let(:station) { double :station }
  context '#new' do
    it "has a entry point" do
      expect(subject.entry_station).to eq nil
    end
    it "has an exit point" do
      expect(subject.exit_station).to eq nil
    end
  end
  context '#update_exit_station' do
    it "updates on last stop" do
      expect{ subject.update_exit_station(station) }.to change{subject.exit_station}.to(station)
    end
  end
  context '#fare' do
    it "returns minimum fare" do
      expect(subject.fare).to eq 1
    end
  end


end
