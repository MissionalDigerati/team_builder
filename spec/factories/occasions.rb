# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :occasion do
  end
  
  factory :defaulted_occasion, :parent => :occasion do
    contact_id 0
    occasion "some text"
    special_date Time.now.to_date
  end
end
