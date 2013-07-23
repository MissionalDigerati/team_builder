class SupportState < ActiveRecord::Base

  belongs_to :contact

  validate :falsify_all_other_states
  
  attr_accessible :contact_id, :initial, :letter_sent, :letter_sent_on, :contacting, :seen_presentation, :presented_on, 
  :following_up, :responding_on, :one_time_gift, :monthly_gift, :not_giving, :no_response, :progress_percent
	
  # this method ensures that the inputted paramater corrilates with a list of the known methods. 
  def self.state_edit_delegation(state, params)
    if self.respond_to?(params) && POSSIBLE_STATES.include?(params)
      self.send(params, state)
    else
      return
  	end
  end

	def self.count_by_progress(progress_column)
		self.where(progress_column => true).count if PROGRESS_COLUMNS.include?(progress_column)
	end

  def self.initial_state(state)
    state.update_attributes(initial: true, letter_sent: false, contacting: false, seen_presentation: false, following_up: false,
    one_time_gift: false, monthly_gift: false, not_giving: false, no_response: false, letter_sent_on: nil, presented_on: nil, responding_on: nil, progress_percent: 14)
  end

  def self.letter_sent(state)
    state.update_attributes(initial: false, letter_sent: true, contacting: false, seen_presentation: false, following_up: false,
    one_time_gift: false, monthly_gift: false, not_giving: false, no_response: false, letter_sent_on: Time.now.to_date, progress_percent: 32)
  end

  def self.contacting(state)
    state.update_attributes(initial: false, letter_sent: false, contacting: true, seen_presentation: false, following_up: false,
    one_time_gift: false, monthly_gift: false, not_giving: false, no_response: false, presented_on: nil, responding_on: nil, progress_percent: 58)
  end

  def self.seen_presentation(state)
    state.update_attributes(initial: false, letter_sent: false, contacting: false, seen_presentation: true, following_up: false,
    one_time_gift: false, monthly_gift: false, not_giving: false, no_response: false, presented_on: Time.now.to_date, responding_on: nil, progress_percent: 75)
  end

  def self.following_up(state)
    state.update_attributes(initial: false, letter_sent: false, contacting: false, seen_presentation: false, following_up: true,
    one_time_gift: false, monthly_gift: false, not_giving: false, no_response: false, responding_on: nil, progress_percent: 85)
  end

  def self.one_time_gift(state)
    state.update_attributes(initial: false, letter_sent: false, contacting: false, seen_presentation: false, following_up: false,
    one_time_gift: true, monthly_gift: false, not_giving: false, no_response: false, responding_on: nil, progress_percent: 100)
  end

  def self.monthly_gift(state)
    state.update_attributes(initial: false, letter_sent: false, contacting: false, seen_presentation: false, following_up: false,
    one_time_gift: false, monthly_gift: true, not_giving: false, no_response: false, responding_on: nil, progress_percent: 100)
  end

  def self.not_giving(state)
    state.update_attributes(initial: false, letter_sent: false, contacting: false, seen_presentation: false, following_up: false,
    one_time_gift: false, monthly_gift: false, not_giving: true, no_response: false, responding_on: nil, progress_percent: 100)
  end

  def self.no_response(state)
    state.update_attributes(initial: false, letter_sent: false, contacting: false, seen_presentation: false, following_up: false,
    one_time_gift: false, monthly_gift: false, not_giving: false, no_response: true, responding_on: nil, progress_percent: 100)
  end

	def progress
		PROGRESS_COLUMNS.each do |pa|
			return pa.to_s.gsub(/[(_)]/, ' ').titlecase if self[pa] === true
		end
	end

  def falsify_all_other_states
    number = 0
    PROGRESS_COLUMNS.each do |pa|
      number += 1 if self[pa] === true
    end
    errors[:base] << "You can only select one state." if number > 1
  end

private

  POSSIBLE_STATES = ["initial_state", "letter_sent", "contacting", "seen_presentation", "following_up", "one_time_gift", "monthly_gift", "not_giving", "no_response"]
	PROGRESS_COLUMNS = [:initial, :letter_sent, :contacting, :seen_presentation, :following_up, :one_time_gift, :monthly_gift, :not_giving, :no_response]
  
end
