module WidgetHelper

  def widget_donation_this_year_data
    donations = Donation.monthly_sums(Time.now.strftime("%Y").to_s)
    donations.each_with_index.map { |x,i| [i, x] }
  end

  def widget_donation_yearly_data
    donations = Donation.yearly_sums.to_json
  end

  def widget_tasks_summary_data
    completed = Task.total_tasks(:completed)
    overdue = Task.total_tasks(:overdue)
    incomplete = Task.total_tasks(:incomplete) - overdue
    [
        {label: "Completed (#{completed})", data: completed},
        {label: "Incomplete (#{incomplete})", data: incomplete},
        {label: "Overdue (#{overdue})", data: overdue}
    ].to_json
  end

  def widget_team_status_summary_data
    colors = {
      pending: '#8dd8ee', sent_letter: '#a8e651', setting_up_a_meeting: '#5584ed', presented_vision: '#f7f156',
      following_up: '#5584ed', special_gift: '#60ad15', monthly_supporter: '#60ad15', cannot_give: '#ad1564', no_response: '#ad1564'
    }
    data = []
    Contact.aasm.states.map(&:name).each do |state|
      results = Contact.team_status_total(state)
      data << {label: "#{state.to_s.humanize.titlecase} (#{results})", data: results, color: colors[state]}
    end
    data.to_json
  end

end