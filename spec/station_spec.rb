require 'station'


describe Station do
    context '#new' do
    it "has a zone equal nil" do
    expect(subject.zone).to eq nil
    end
    it "has a name" do
    expect(subject.name).to eq ""
    end
  end
end
