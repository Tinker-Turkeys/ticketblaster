require 'spec_helper'

describe CustomField do

  describe "#label" do
    it { should respond_to(:label) }
  end

  describe "#type" do
    it { should respond_to(:type) }
  end

  describe "#name" do
    it { should respond_to(:name) }
  end

  describe "#value" do
    it { should respond_to(:value) }
  end

  describe "#options" do
    it { should respond_to(:options) }
  end

  describe "#label" do
    context "when it is set to 'Main Course ;-)'" do
      it "sets #name to 'main-course'" do
        subject.label = "Main Course ;-)"
        expect(subject.name).to eq('main-course')
      end
    end
  end
end