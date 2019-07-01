require 'oystercard'


describe Oystercard do
  subject(:oystercard) { described_class.new }
  describe '#new' do
    it "has no balance when inititialized" do
      expect(oystercard.balance).to eq 0
    end
  end
end
