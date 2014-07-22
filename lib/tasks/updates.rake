namespace :updates do

  desc "Update all contacts prior to support_states being removed"
  task :prior_to_support_state_removal => :environment do
    Contact.all.each do |c|
      support_state = c.support_state
      c.letter_sent_on = support_state.letter_sent_on
      c.presented_vision_on = support_state.presented_on
      c.responded_on = support_state.responding_on
      if support_state.initial === true
        c.team_status = :pending
      elsif support_state.letter_sent === true
        c.team_status = :sent_letter
        c.sent_letter = :true
      elsif support_state.contacting === true
        c.team_status = :setting_up_a_meeting
      elsif support_state.seen_presentation === true
        c.team_status = :presented_vision
        c.presented_vision = true
      elsif support_state.following_up === true
        c.team_status = :following_up
      elsif support_state.one_time_gift === true
        c.team_status = :special_gift
      elsif support_state.monthly_gift === true
        c.team_status = :monthly_supporter
      elsif support_state.not_giving === true
        c.team_status = :cannot_give
      elsif support_state.no_response === true
        c.team_status = :no_response
      end
      c.team_status_updated_on = Date.today
      c.save
    end
  end

end