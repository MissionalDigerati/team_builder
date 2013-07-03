class SupportState < ActiveRecord::Base

  belongs_to :contact
  
  attr_accessible :contact_id, :initial, :letter_sent, :letter_sent_on, :contacting, :seen_presentation, :presented_on, 
  :following_up, :responding_on, :one_time_gift, :monthly_gift, :not_giving, :no_response

  # this method ensures that the inputted paramater corrilates with a list of the known methods. 
  def self.state_edit_delegation(state, params)
    if self.respond_to?(params) && POSSIBLE_STATES.include?(params)
      self.send(params, state)
    else
      return
  	end
  end

  def self.initial_state(state)
    state.update_attributes(initial: true, letter_sent: false, contacting: false, seen_presentation: false, following_up: false,
    one_time_gift: false, monthly_gift: false, not_giving: false, no_response: false, letter_sent_on: nil, presented_on: nil, responding_on: nil)
  end

  def self.letter_sent(state)
    state.update_attributes(initial: false, letter_sent: true, contacting: false, seen_presentation: false, following_up: false,
    one_time_gift: false, monthly_gift: false, not_giving: false, no_response: false, letter_sent_on: Time.now.to_date)
  end

  def self.contacting(state)
    state.update_attributes(initial: false, letter_sent: false, contacting: true, seen_presentation: false, following_up: false,
    one_time_gift: false, monthly_gift: false, not_giving: false, no_response: false, presented_on: nil, responding_on: nil)
  end

  def self.seen_presentation(state)
    state.update_attributes(initial: false, letter_sent: false, contacting: false, seen_presentation: true, following_up: false,
    one_time_gift: false, monthly_gift: false, not_giving: false, no_response: false, presented_on: Time.now.to_date, responding_on: nil)
  end

  def self.following_up(state)
    state.update_attributes(initial: false, letter_sent: false, contacting: false, seen_presentation: false, following_up: true,
    one_time_gift: false, monthly_gift: false, not_giving: false, no_response: false, responding_on: nil)
  end

  def self.one_time_gift(state)
    state.update_attributes(initial: false, letter_sent: false, contacting: false, seen_presentation: false, following_up: false,
    one_time_gift: true, monthly_gift: false, not_giving: false, no_response: false, responding_on: nil)
  end

  def self.monthly_gift(state)
    state.update_attributes(initial: false, letter_sent: false, contacting: false, seen_presentation: false, following_up: false,
    one_time_gift: false, monthly_gift: true, not_giving: false, no_response: false, responding_on: nil)
  end

  def self.not_giving(state)
    state.update_attributes(initial: false, letter_sent: false, contacting: false, seen_presentation: false, following_up: false,
    one_time_gift: false, monthly_gift: false, not_giving: true, no_response: false, responding_on: nil)
  end

  def self.no_response(state)
    state.update_attributes(initial: false, letter_sent: false, contacting: false, seen_presentation: false, following_up: false,
    one_time_gift: false, monthly_gift: false, not_giving: false, no_response: true, responding_on: nil)
  end

private
  
  POSSIBLE_STATES = ["initial_state", "letter_sent", "contacting", "seen_presentation", "following_up", "one_time_gift", "monthly_gift", "not_giving", "no_response"]

end
