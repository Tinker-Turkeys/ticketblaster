# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invitee do
    event nil
    registration nil
    name "MyString"
    email "MyString"
    phone_number "MyString"
  end
end
