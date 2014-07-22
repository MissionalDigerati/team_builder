FactoryGirl.define do
  
  factory :contact do
  end
  
  factory :defaulted_contact, :parent => :contact do
    first_name "Rory"
    last_name "Williams"
    email "fred@fakeemail.com"
    team_status :sent_letter
  end
   
end