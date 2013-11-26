require 'spec_helper'

describe Registration do

  let(:registration) { FactoryGirl.build(:thanksgiving_registration) }

  describe "Factory" do
    it "is valid" do
      expect(registration).to be_valid
    end
  end

  describe "#event" do
    it { should respond_to(:event) }
    it "returns the event it belongs to" do
      expect(registration.event).to be_a(Event)
    end
  end

  describe "#price" do
    it { should respond_to(:price) }
    context "when price is below 1" do
      it "is valid" do
        registration.price = 1
        expect(registration).to be_valid
      end
    end
    context "when price is 0" do
      it "is valid" do
        registration.price = 0
        expect(registration).to be_valid
      end
    end
    context "when price is below 0" do
      it "is not valid" do
        registration.price = -1
        expect(registration).to be_invalid
      end
    end
  end
end
