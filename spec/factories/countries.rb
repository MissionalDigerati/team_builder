# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :country do
    iso "MyString"
    name "MyString"
    printable_name "MyString"
    iso3 "MyString"
    numcode 1
  end
end
