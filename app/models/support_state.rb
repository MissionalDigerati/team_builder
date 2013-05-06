class SupportState < ActiveRecord::Base

  belongs_to :contact
  
  attr_accessible :contact_id, :initial, :letter_sent, :letter_sent_on, :contacting, :seen_presentation, :presented_on, 
  :following_up, :responding_on, :one_time_gift, :monthly_gift, :not_giving, :no_response

  validates :initial, :letter_sent, :contacting, :seen_presentation, :following_up, :one_time_gift, :monthly_gift, :not_giving, :no_response, presence: true

end
