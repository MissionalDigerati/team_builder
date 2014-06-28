json.array!(@reoccuring_occasions) do |occasion|
    json.id occasion.id
    json.title occasion.occasion
    json.start occasion.calendar_date
    json.date_formatted occasion.special_date.strftime('%B %d')
    json.allDay true
    json.editable false
    json.backgroundColor '#5eb2d9'
    json.textColor '#FFFFFF'
    json.borderColor '#FFFFFF'
    if occasion.contact.nil?
        json.contact nil
    else
        json.url contact_path(occasion.contact_id)
        json.contact do
            json.id occasion.contact.id
            json.name occasion.contact.family_name
            json.view_link contact_path(occasion.contact_id)
        end
    end
end