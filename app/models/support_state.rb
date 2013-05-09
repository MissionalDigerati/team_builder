class SupportState < ActiveRecord::Base

  belongs_to :contact
  
  attr_accessible :contact_id, :initial, :letter_sent, :letter_sent_on, :contacting, :seen_presentation, :presented_on, 
  :following_up, :responding_on, :one_time_gift, :monthly_gift, :not_giving, :no_response

  def self.state_edit_delegation(state_id, params)
  	state = self.find(state_id)
  	if params == "initial"
  		self.initial_state(state)
  	end
  end

  def self.initial_state(state)
    state.update_attributes(initial: true, letter_sent: false, contacting: false, seen_presentation: false, following_up: false, responding_on: false,
    one_time_gift: false, monthly_gift: false, not_giving: false, no_response: false, letter_sent_on: nil, presented_on: nil, responding_on: nil)
  end

end
