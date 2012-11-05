# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :state, :class => 'States' do
    state_long "MyString"
    state_short "MyString"
  end
end
