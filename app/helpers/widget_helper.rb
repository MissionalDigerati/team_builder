module WidgetHelper

  def widget_donation_this_year_data
    donations = Donation.monthly_sums(Time.now.strftime("%Y").to_s)
    donations.each_with_index.map { |x,i| [i, x] }
  end

  def widget_donation_yearly_data
    donations = Donation.yearly_sums.to_json
  end

end