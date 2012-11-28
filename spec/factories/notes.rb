# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :note do
  end
  factory :defaulted_note, :parent => :note do
    contact_id 0
    note "some text"
  end
end