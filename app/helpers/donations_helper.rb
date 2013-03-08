module DonationsHelper
	def user_donation_amount(donations=0)
		"Total donation amount: #{number_to_currency(donations.sum(:amount), :precision => 2)}"
	end
end
