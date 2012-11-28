FactoryGirl.define do
  
  factory :contact do
  end
  
  factory :defaulted_contact, :parent => :contact do
    first_name "Fred"
    email "fred@fakeemail.com"
  end
   
end