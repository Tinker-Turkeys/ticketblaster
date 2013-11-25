require 'feature_helper'

feature "Create event" do

  let(:event) { FactoryGirl.build(:thanksgiving) }
  
  before do
    visit new_event_path
  end

  scenario "Creating a new event" do
    fill_in "event[title]", with: event.title
    fill_in "event[description]", with: event.description
    fill_in "event[occurring_on]", with: event.occurring_on
    fill_in "event[location]", with: event.location
    fill_in "event[image_url]", with: event.image_url
    fill_in "event[slots]", with: event.slots
    fill_in "event[location]", with: event.location
    check "event[published]" if event.published?
    choose event.public? ? "Public" : "Private"
    click_button "Create Event"

    new_event = Event.last

    expect(current_path).to eq(event_path(new_event))
  end

end