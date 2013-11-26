require 'spec_helper'

describe Event do

  let(:event) { FactoryGirl.build(:thanksgiving) }

  describe "Factory" do
    it "is valid" do
      expect(event).to be_valid
    end
  end

  describe "#title" do
    it { should respond_to(:title) }
    context "when it is 3 characters long" do
      it "is valid" do
        event.title = "a" * 3
        expect(event).to be_valid 
      end
    end

    context "when it is 2 characters long" do
      it "is invalid" do
        event.title = "a" * 2
        expect(event).to be_invalid 
      end
    end

    context "when it is blank" do
      it "is invalid" do
        event.title = nil
        expect(event).to be_invalid 
      end
    end
  end

  describe "#description" do
    it { should respond_to(:description) }
    context "when it is 25 characters long" do
      it "is valid" do
        event.description = "a" * 25
        expect(event).to be_valid 
      end
    end

    context "when it is 24 characters long" do
      it "is invalid" do
        event.description = "a" * 24
        expect(event).to be_invalid 
      end
    end

    context "when it is blank" do
      it "is invalid" do
        event.description = nil
        expect(event).to be_invalid 
      end
    end

    context "when it is more than 1M characters" do
      it "is invalid" do
        event.description.stub(:length) { 1000001 }
        expect(event).to be_invalid 
      end
    end

    context "when it is 1M characters" do
      it "is valid" do
        event.description.stub(:length) { 1000000 }
        expect(event).to be_valid 
      end
    end
    
  end

  describe "#occurring_on" do
    it { should respond_to(:occurring_on) }

    context "when it is in the past" do
      it "is not valid" do
        event.occurring_on = Time.now
        expect(event).to be_invalid
      end
    end

    context "when it is 10 minutes from now" do
      it "is valid" do
        event.occurring_on = 10.minutes.from_now
        expect(event).to be_valid
      end
    end

    context "when it is 365 days from now" do
      it "is valid" do
        event.occurring_on = 365.days.from_now
        expect(event).to be_valid
      end
    end

    context "when it is 366 days from now" do
      it "is invalid" do
        event.occurring_on = 366.days.from_now
        expect(event).to be_invalid
      end
    end

  end

  describe "#location" do
    it { should respond_to(:location) }
    context "when it is 3 characters long" do
      it "is valid" do
        event.location = "a" * 3
        expect(event).to be_valid 
      end
    end

    context "when it is 2 characters long" do
      it "is invalid" do
        event.location = "a" * 2
        expect(event).to be_invalid 
      end
    end

    context "when it is blank" do
      it "is invalid" do
        event.location = nil
        expect(event).to be_invalid 
      end
    end

  end

  describe "#image_url" do
    it { should respond_to(:image_url) }
  end

  describe "#slots" do
    it { should respond_to(:slots) }

    context "when it is 1" do
      it "is valid" do
        event.slots = 1
        expect(event).to be_valid 
      end
    end

    context "when it is -1" do
      it "is valid" do
        event.slots = -1
        expect(event).to be_valid 
      end
    end

    context "when it is nil" do
      it "is invalid" do
        event.slots = nil
        expect(event).to be_invalid 
      end
    end

    context "when it is a string" do
      it "is invalid" do
        event.slots = "five"
        expect(event).to be_invalid 
      end
    end

  end

  describe "#published" do
    it { should respond_to(:published) }

    context "when it is true" do
      it "is valid" do
        event.published = true
        expect(event).to be_valid
      end      
    end

    context "when it is false" do
      it "is valid" do
        event.published = false
        expect(event).to be_valid
      end      
    end

    context "when it is nil" do
      it "is invalid" do
        event.published = nil
        expect(event).to be_invalid
      end      
    end

  end

  describe "#public" do
    it { should respond_to(:public) }

    context "when it is true" do
      it "is valid" do
        event.public = true
        expect(event).to be_valid
      end      
    end

    context "when it is false" do
      it "is valid" do
        event.public = false
        expect(event).to be_valid
      end      
    end

    context "when it is nil" do
      it "is invalid" do
        event.public = nil
        expect(event).to be_invalid
      end      
    end

  end

  describe "#custom_fields_json" do
    it { should respond_to(:custom_fields_json) }

    context "when it includes a valid custom form field" do

      it "dosen't raise an error" do
        expect{JSON.load(event.custom_fields_json)}.to_not raise_error{JSON::ParserError} 
      end
    end

    context "when it includes an invalid custom form field" do

      it "does raise an error" do
        expect do 
          event.custom_fields_json = "(label: 'main course')"
        end
        .to raise_error{JSON::ParserError}
      end
    end

  end

  describe "#custom_fields" do

    it "returns an array of custom fields" do
      expect(event.custom_fields.first).to be_a(CustomField)  
    end
  end

  describe "#add_custom_fields" do
    it "returns an added custom field" do
      event.add_custom_fields([{ label: "Alcohol", type: "text_field",
                value: "enter drinks here", options: ""}])
      expect(event.custom_fields.last.label).to eq("Alcohol")
    end
  end

end
