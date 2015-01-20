require 'hamster/versions/ref'

describe Hamster::Versions::Ref do
  it("refers an empty hash by default") { expect(subject.deref).to eq Hamster::Hash.empty }
  it("dosync creates a new generation") { expect(subject.dosync(name: 'Alvin').deref[:name]).to eq 'Alvin' }
  it("older is nil") { expect(subject.older).to be_nil }
  it("newer is nil") { expect(subject.newer).to be_nil }
  context "second generation" do
    before { subject.dosync(name: 'Alvin') }
    it("dosync creates a newer generation") { expect(subject.newer.deref[:name]).to eq 'Alvin' }
    context "third generation" do
      before { subject.newer.dosync(name: 'Simon') }
      it("") { expect(subject.newest.deref[:name]).to eq 'Simon' }
      it("#newest is a shorthand to the newest generation") { expect(subject.newest).to be subject.newer.newer }
      it("#oldest is a shorthand to the oldest generation") { expect(subject.newest.oldest).to be subject }
      it("the second generation cannot be changed anymore") { expect{subject.newer.dosync(name: 'Theodore') }.to raise_error(RuntimeError, /can't modify frozen/) }
    end
  end
end
