# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :support_state do
  end
  factory :defaulted_support_state, parent: :support_state do
  	contact_id 0
  	initial true
  	letter_sent true
  	letter_sent_on Time.now.to_date
  	contacting  true
  	seen_presentation true
  	presented_on Time.now.to_date
  	following_up true
  	responding_on Time.now.to_date
  	one_time_gift true
  	monthly_gift true
  	not_giving true
  	no_response true
    progress_percent 10
  end
	factory :starting_support_state, parent: :support_state do
  	contact_id 0
  	initial true
  	letter_sent false
  	letter_sent_on Time.now.to_date
  	contacting  false
  	seen_presentation false
  	presented_on Time.now.to_date
  	following_up false
  	responding_on Time.now.to_date
  	one_time_gift false
  	monthly_gift false
  	not_giving false
  	no_response false
    progress_percent 10
  end
end
