module ApplicationHelper
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id ) do |builder|
      render( association.to_s.singularize + "_fields", f: builder )
    end
    link_to(name, '#', class: "add_fields btn btn-small btn-warning", data: {id: id, fields: fields.gsub("/n", "")})
  end
   
  def status(status)
     if status === true
       "Completed"
     else
       "In Progress"
     end
  end
  
  def first_name(arg)
    arg.contact.first_name.capitalize
  end
    
  def edit_button
    'Edit <i class="icon-edit icon-white"></i>'.html_safe
  end  
  
  def delete_button
    'Delete <i class="icon-trash icon-white"></i>'.html_safe
  end
    
  def contact_button
    'View Contact <i class="icon-user icon-white"></i>'.html_safe
  end
  
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end
  
  def donations_all_time
    total_donations = Donation.sum(:amount)
    number_to_currency(total_donations, :precision => 2)
  end
  
  # These queries for finding by month and year will need to be changed depending on the database used, here I use sqlite 
  # http://stackoverflow.com/questions/9624601/activerecord-find-by-year-day-or-month-on-a-date-field
  
  def donation_this_year
    current_year = Time.now.year
    # Donation.sum(:amount, Donation.where(:donation_date == current_month))
    donation_year = Donation.where("strftime('%Y', donation_date)     = ?", current_year.to_s)
    donation_year_sum = currency(donation_year.sum(:amount))
  end
  
  def currency(number)
    number_to_currency(number, :precision => 2)
  end

  
end

