class SupportState < ActiveRecord::Base

  belongs_to :contact
  
  attr_accessible :contact_id, :initial, :letter_sent, :letter_sent_on, :contacting, :seen_presentation, :presented_on, 
  :following_up, :responding_on, :one_time_gift, :monthly_gift, :not_giving, :no_response

  def self.state_edit_delegation(client, state, params)
  	state = self.where("id = ? AND client_id = ?", client, state)
  	if params == "initial"
  		self.initial_state(state)
  	end
  end

  def self.initial_state(state)
  	state.initial = true
  	state.letter_sent = true
  	state.contacting = true
  	state.seen_presentation = true
  	state.following_up = true
  	state.responding_on = true
  	state.one_time_gift = true
  	state.monthly_gift = true
  	state.not_giving = true
  	state.no_response = true
  	state.letter_sent_on = nil
  	state.presented_on = nil
  	state.save
  end

end
