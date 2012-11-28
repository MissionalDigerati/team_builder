# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :donation do
  end
  factory :defaulted_donation, :parent => :donation do
    amount 72.25
    project "Team Builder"
    contact_id 0
    donation_date Time.now.to_date
  end
end
