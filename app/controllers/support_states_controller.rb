class SupportStatesController < ApplicationController

	def new
		@contact = Contact.find(params[:contact_id])
		@support_state = @contact.build_support_state
	end

	def create
		@contact = Contact.find(params[:contact_id])
		@support_state = @contact.build_support_state(params[:support_state])
		respond_to do |format|
			if @support_state.save
				format.html {redirect_to(contact_path(@contact))}
				flash[:notice] = "Support state has been saved!"
			else
				redirect_to :back
				flash[:notice] = @donations.errors.full_messages.to_sentence
			end
		end
	end

	def edit
		@contact = Contact.find(params[:contact_id])
		@support_state = SupportState.find(params[:id])
	end

	def update
		@contact = Contact.find(params[:contact_id])
		@support_state = SupportState.find(params[:id])
		respond_to do |format|
			if @support_state.update_attributes(params[:support_state])
				format.html {redirect_to(contact_path(@contact))}
				flash[:notice] = "Support state has been updated!"
			else
				format.html {render action: "edit"}
				flash[:notice] = @support_state.errors.to_sentence
			end
		end
	end

	def quick_edit
		@contact = Contact.find(params[:contact_id])
		@state = SupportState.find(params[:id])
		SupportState.state_edit_delegation(@state, params[:current_state])
		# redirect_to contact_path(params[:contact_id])
		respond_to do |format|
			format.js
			# format.html {redirect_to contact_path(params[:contact_id])}
			@message = "Support state has been updated to #{params[:current_state].titleize}."
		end
	end
end
