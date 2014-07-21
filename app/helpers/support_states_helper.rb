module SupportStatesHelper

	def total_contacts
		@total_contacts ||= Contact.contact_count
	end

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

	def status_progress_bar(state)
		progress_count = SupportState.count_by_progress(state)
		if progress_count > 0
			percentage = (progress_count.to_f / total_contacts.to_f) * 100
			bar_class = "progress_#{state.to_s.downcase.parameterize}".tr("_", '-')
			html = "<h5>#{state.to_s.titleize} (#{percentage.round}% / #{progress_count} People)</h5><div class='progress #{bar_class}'>";
	    html += "<div class='bar' style='width: #{percentage.round}%'>#{percentage.round}%</div>"
	    html += "</div>"
	  end
	end

end
