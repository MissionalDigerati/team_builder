# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :presence do
  end
  
  factory :defaulted_presence, :parent => :presence do
    site "Facebook"
    url "http://www.fakeuser.com"
    account "Fake.J.Name"
    contact_id 0
  end
end