module ApplicationHelper
  
  #This adds extra fields as needed on the new contact form. 
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id ) do |builder|
      render( association.to_s.singularize + "_fields", f: builder )
    end
    link_to(name, '#', class: "add_fields btn btn-sm btn-danger", data: {id: id, fields: fields.gsub("/n", "")})
  end
  
  #this displays the pill on stating what you're searching by on when filtering contacts by search or by tags.
  def tag_param
    if request.params["tag"].present?
      text = "Searching by tag: #{request.params["tag"].titleize}" 
      link_to text, "", :class => "label label-important"
    elsif request.params["search"].present?
      text = "Searching for: #{request.params["search"].titleize}" 
      link_to text, "", :class => "label label-important"
    end
  end
   
  def status(status)
     status === true ? "Completed" : "In Progress"
  end
  
  #Creates a collection of the first and last names of users on the drop down lists when creating anything other than a contact.
  def form_select
    if Contact.order("last_name ASC, first_name ASC").collect.present?
      Contact.order("last_name ASC, first_name ASC").collect {|p| [ p.last_name + ', ' + p.first_name, p.id ] }
    end
  end
  
  def first_name(instance)
    instance.contact.first_name.capitalize
  end
  
  def summary_name_helper(instance)
    instance.contact.last_name.capitalize + ', ' + instance.contact.first_name.first.capitalize
  end
  
  def full_name(instance)
    instance.first_name + " " + instance.last_name.titleize
  end
  
  #shortcuts for buttons with white icons used throughout the app
  def edit_button
    'Edit <i class="fa fa-edit"></i>'.html_safe
  end  
  
  def delete_button
    'Delete <i class="fa fa-trash-o"></i>'.html_safe
  end
    
  def contact_button
    'View Contact <i class="fa fa-user"></i>'.html_safe
  end
  
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end
  
  def currency(number)
    number_to_currency(number, :precision => 2)
  end
  
  def donations_all_time
    total_donations = Donation.sum(:amount)
    currency(total_donations)
  end
  
  # These queries for finding by month and year will need to be changed depending on the database used, here I use sqlite 
  # http://stackoverflow.com/questions/9624601/activerecord-find-by-year-day-or-month-on-a-date-field
  
  def donation_this_year
    donation_year = Donation.where("EXTRACT(YEAR FROM donation_date)::int = ?", Time.now.year.to_s)
    currency(donation_year.sum(:amount))
  end

  def number_of_contacts
    total_contacts = Contact.all.length
    total_contacts.present? ? "#{total_contacts}" : "0"
  end

  def number_of_overdue_tasks
    tasks_overdue = Task.overdue.count
    tasks_overdue.present? ? "#{tasks_overdue}" : "0"
  end

  def occasions_today
    occasions_today = Occasion.special_date_today.length
    occasions_today.present? ? "#{occasions_today}" : "0"
  end

  def pluralize_without_count(count, noun, text = nil)
    count == 1 ? "#{noun}#{text}" : "#{noun.pluralize}#{text}"
  end

end