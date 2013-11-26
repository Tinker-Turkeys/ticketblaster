# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    factory :thanksgiving do
      title "Thanksgiving at Momma's"
      description "Come eat turkey at my mom's house. Bring some brews."
      occurring_on "2013-11-28 14:00"
      location "11 Broadway, NY, NY"
      image_url "http://bit.ly/1he2Uvg"
      slots 10
      published true
      public true
      custom_fields_json ([{ label: "Dish", type: "text_field",
        value: "enter dish here", options: "" }].to_json)
    end
  end
end
