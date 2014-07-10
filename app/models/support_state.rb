class SupportState < ActiveRecord::Base

  belongs_to :contact

  validate :one_state_validation

  after_validation :calculate_progress_percentage
	
  # this method ensures that the inputted paramater corrilates with a list of the known methods. 
  def self.state_edit_delegation(state, params)
    if self.respond_to?(params) && POSSIBLE_STATES.include?(params)
      self.send(params, state)
    else
      return
  	end
  end

  # using splat to get multiple params
	def self.count_by_progress(*progress_column)
    where_clause = ''
    progress_column.each_with_index do |pc, i|
      where_clause = (i == 0) ? "#{pc} = 't'" : "#{where_clause} OR #{pc} = 't'"
    end
		self.where(where_clause).count if (progress_column - PROGRESS_COLUMNS).empty?
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

	def progress
		PROGRESS_COLUMNS.each do |pa|
			return pa.to_s.gsub(/[(_)]/, ' ').titlecase if self[pa] === true
		end
	end

  def one_state_validation
    number = 0
    PROGRESS_COLUMNS.each do |pa|
      number += 1 if self[pa] === true
    end
    errors[:base] << "You can only select one state." if number > 1
  end

  def calculate_progress_percentage
    if self.not_giving == true || self.no_response == true || self.monthly_gift == true || self.one_time_gift == true
      self.progress_percent = 100
    elsif self.following_up == true
      self.progress_percent = 85
    elsif self.seen_presentation == true
      self.progress_percent = 75
    elsif self.contacting == true
      self.progress_percent = 58
    elsif self.letter_sent == true
      self.progress_percent = 32
    elsif self.initial == true
      self.progress_percent = 14  
    end
  end

private

  POSSIBLE_STATES = ["initial_state", "letter_sent", "contacting", "seen_presentation", "following_up", "one_time_gift", "monthly_gift", "not_giving", "no_response"]
	PROGRESS_COLUMNS = [:initial, :letter_sent, :contacting, :seen_presentation, :following_up, :one_time_gift, :monthly_gift, :not_giving, :no_response]
  
end
