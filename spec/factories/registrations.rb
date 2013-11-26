# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :registration do
    factory :thanksgiving_registration do
      user nil
      # association :user, factory: :user
      association :event, factory: :thanksgiving
      price 10000
    end
  end
end
