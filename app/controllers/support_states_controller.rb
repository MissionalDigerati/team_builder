class SupportStatesController < ApplicationController

	before_filter :set_contact_variable
	before_filter :set_support_state_variable, :only => [:edit, :update]

	def new
		@support_state = @contact.build_support_state
	end

	def create
		@support_state = @contact.build_support_state(support_state_params)
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
	end

	def update
		respond_to do |format|
			if @support_state.update_attributes(support_state_params)
				format.html {redirect_to(contact_path(@contact))}
				flash[:notice] = "Support state has been updated!"
			else
				format.html {render action: "edit"}
				flash[:notice] = @support_state.errors.full_messages.to_sentence
			end
		end
	end

	def quick_edit
		@state = SupportState.find(params[:id])
		SupportState.state_edit_delegation(@state, params[:current_state])
		# redirect_to contact_path(params[:contact_id])
		respond_to do |format|
			format.js
			# format.html {redirect_to contact_path(params[:contact_id])}
			@message = "Support state has been updated to #{params[:current_state].titleize}."
		end
	end

	def set_contact_variable
		@contact = Contact.find(params[:contact_id])
	end

	def set_support_state_variable
		@support_state = SupportState.find(params[:id])
	end

	private
		def support_state_params
			params.require(:support_state).permit(:contact_id, :initial, :letter_sent, :letter_sent_on, :contacting, :seen_presentation, :presented_on, 
  :following_up, :responding_on, :one_time_gift, :monthly_gift, :not_giving, :no_response, :progress_percent)
		end

end
