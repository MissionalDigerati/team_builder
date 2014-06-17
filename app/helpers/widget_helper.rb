module WidgetHelper

  def widget_donation_data
    donations = Donation.monthly_sums(Time.now.strftime("%Y").to_s)
    donations.each_with_index.map { |x,i| [i, x] }
  end

end