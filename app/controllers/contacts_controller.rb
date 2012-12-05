class ContactsController < ApplicationController
  helper_method :sort_column, :sort_direction
  # GET /contacts
  # GET /contacts.json
  before_filter :sub_contact_info, :only => [:show] 
  
  #
  #passes sortable info the the main contact table on the contact index page. 
  # Also passes all the new contacts from the past week in the instance variable @new_contacts
  def index
    if params[:tag]
      @contacts = Contact.tagged_with(params[:tag]).page(params[:page])
    elsif params[:search].present? && params[:search].first == "#"
      params[:search][0] = ''
      @contacts = Contact.tagged_with(params[:search]).page(params[:page])
    elsif params[:search].present?
      @contacts = Contact.where("first_name like ?", params[:search]).page(params[:page])
    else
      @contacts = Contact.order(sort_column + " " + sort_direction).page(params[:page])
    end
    
    @new_contacts = Contact.find(:all, :conditions => ["created_at between ? and ?", 1.weeks.ago.to_date, Time.now.to_date])
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contacts }
    end
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
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
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contact }
    end
  end

  # GET /contacts/1/edit
  def edit
    @contact = Contact.find(params[:id])
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
      @number = @contact.numbers.where(:contact_id == @contact)
      @occasion = @contact.occasions.where(:contact_id == @contact)
      @donation = @contact.donations.where(:contact_id == @contact)
      @task = @contact.tasks.where(:contact_id => @contact, :completed => false )
      @note = @contact.notes.where(:contact_id == @contact)
      @presence = @contact.presences.where(:contact_id == @contact)
    end
    
  protected
  
  def sort_column
    Contact.column_names.include?(params[:sort]) ? params[:sort] : "last_name, first_name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  
end
