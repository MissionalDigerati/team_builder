json.array!(@reoccuring_occasions) do |occasion|
    json.id occasion.id
    json.title occasion.occasion
    json.start occasion.calendar_date
    json.date_formatted occasion.special_date.strftime('%B %d')
    json.allDay true
    json.editable false
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