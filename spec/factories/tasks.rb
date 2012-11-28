# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence(:task){ |n| "do #{n} jumping jacks"}
  factory :task do
  end
  factory :defaulted_task, :parent => :task do
    task
    due_date Time.now.to_date
    category "Defaulted task"
    contact_id 0  
  end
end
