# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    title "MyString"
    description "MyText"
    occurring_on "2013-11-25 15:04:27"
    location "MyString"
    image_url "MyString"
    slots 1
    published false
    public false
    form_fields "MyText"
  end
end
