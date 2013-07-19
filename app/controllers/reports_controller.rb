class ReportsController < ApplicationController

	def progress
		@contacts = Contact.contact_report_query
	end
end
