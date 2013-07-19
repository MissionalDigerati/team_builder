module SupportStatesHelper

	def display_progress_bar(state)
		if state.present?
			if state.not_giving == true || state.no_response == true
				"<div class='progress'><div class='bar bar-danger progress_text' style='width: #{state.progress_percent}%'>#{state.progress}</div></div>".html_safe
			elsif state.monthly_gift == true || state.one_time_gift == true
				"<div class='progress'><div class='bar bar-success progress_text' style='width: #{state.progress_percent}%'>#{state.progress}</div></div>".html_safe
			elsif state.contacting == true || state.following_up == true || state.seen_presentation == true
				"<div class='progress'><div class='bar bar-info progress_text' style='width: #{state.progress_percent}%'>#{state.progress}</div></div>".html_safe
			elsif state.initial == true || state.letter_sent == true 
				"<div class='progress progress'><div class='bar bar-warning progress_text' style='width: #{state.progress_percent}%'>#{state.progress}</div></div>".html_safe
			end
		end
	end

end
