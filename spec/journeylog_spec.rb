require 'journeylog'

describe JourneyLog do
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }
  let(:journey_fine) { double :journey, :journey => "Bum" , :add_entry_journey => nil, :add_exit_station => nil, :fare => 1 }
  let(:journey_with_penalty) { double :journey, :add_entry_journey => nil, :add_exit_station => nil, :fare => 6 }
  context '#start' do
    it 'starts a new journey with an entry station' do
      subject.start(entry_station, journey_fine)
    expect(subject.journey.journey).to eq "Bum"
    end
  end

  context '#finish' do
    it 'adds an exit_station to the current journey' do

    end
  end

  context '#journeys' do
    it 'returns a list of all previous journeys' do

    end
    it 'cannot called journeys array' do

    end
  end

end

# new_journey = Journey.new
# new_journey.add_entry_journey("whatever")
# p new_journey.journey
