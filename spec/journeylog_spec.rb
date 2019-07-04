require 'journeylog'

describe JourneyLog do
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }
  let(:journey_log) { double :journey_log }
  let(:journey_class) {double :journey_class, :new => journey_fine }
  let(:journey_fine) { double :journey_fine, :journey => nil, :add_entry_journey => "entry_station" , :entry_journey => "entry_station" , :exit_journey => "exit_station", :add_exit_station => nil, :fare => 1 }
  let(:journey_with_penalty) { double :journey_with_penalty, :add_entry_journey => nil, :add_exit_station => nil, :fare => 6 }
  context '#start' do
    it 'starts a new journey with an entry station' do
      subject = JourneyLog.new(journey_class)
      subject.start(entry_station)
      expect(subject.journey.entry_journey).to eq "entry_station"
    end
  end

  context '#finish' do
    it 'adds an exit_station to the current journey' do
      subject = JourneyLog.new(journey_class)
      subject.finish(exit_station)
      expect(subject.journey.exit_journey).to eq "exit_station"
    end
  end

  context '#journeys' do
    it 'returns a list of all previous journeys' do
      subject = JourneyLog.new(journey_class)
      expect(subject.journeys).to eq []
    end
  end

end

# new_journey = Journey.new
# new_journey.add_entry_journey("whatever")
# p new_journey.journey
