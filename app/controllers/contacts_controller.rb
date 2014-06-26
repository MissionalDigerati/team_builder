class ContactsController < ApplicationController
  helper_method :sort_column, :sort_direction
  # GET /contacts
  # GET /contacts.json
  before_filter :sub_contact_info, :only => [:show] 
  
  #
  # passes sortable info the the main contact table on the contact index page.
  # the tag and search param are passed if searching with the search bar or by tags, it filters the contacts according to the search. 
  def index
    if params[:search] || params[:tag]
      @contacts = Contact.contact_search_and_tag_delegation(params[:tag], params[:search]).page(params[:page])
    else
      @contacts = Contact.order(sort_column + " " + sort_direction).page(params[:page])
    end
    @tags = Contact.tag_counts_on(:tags)
    respond_to do |format|
      format.js
      format.html # index.html.erb
      format.json { render json: @contacts }
    end
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
    @state = @contact.support_state
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @contact }
    end
  end

  # GET /contacts/new
  # GET /contacts/new.json
  def new
    @contact = Contact.new(:state_id => 5, :country_id => 226)
    @contact.numbers.build
    @contact.occasions.build
    @contact.presences.build
    @contact.build_support_state
    @tags = ActsAsTaggableOn::Tag.all.collect(&:name)
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contact }
    end
  end

  # GET /contacts/1/edit
  def edit
    @contact = Contact.find(params[:id])
    @tags = ActsAsTaggableOn::Tag.all.collect(&:name)
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.new(params[:contact])

    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, notice: 'Contact was successfully created.' }
        format.json { render json: @contact, status: :created, location: @contact }
      else
        format.html { render action: "new" }
        flash[:notice] = @contact.errors.empty? ? "Your Contact has not been saved" : "Your Contact has not been saved because: " + @contact.errors.full_messages.to_sentence
      end
    end
  end

  # PUT /contacts/1
  # PUT /contacts/1.json
  def update
    @contact = Contact.find(params[:id])

    respond_to do |format|
      if @contact.update_attributes(params[:contact])
        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        flash[:notice] = @contact.errors.empty? ? "Your Contact has not been updated" : "Your Contact has not been updated because: " + @contact.errors.full_messages.to_sentence
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to contacts_url }
      format.json { head :no_content }
    end
  end
  
  
  private
  
    def sub_contact_info
      @contact = Contact.find(params[:id])
      @tasks = @contact.tasks.where(:completed => false )
      @notes = @contact.notes.order("created_at DESC")
    end
    
  protected
  def sort_column
    Contact.column_names.include?(params[:sort]) ? params[:sort] : "last_name, first_name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end