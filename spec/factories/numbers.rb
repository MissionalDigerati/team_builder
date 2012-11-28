# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :number do
  end
  
  factory :defaulted_number, :parent => :number do
    number "1232123212"
    phone_type "Mobile"
    contact_id 0
  end
end