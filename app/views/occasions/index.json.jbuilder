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
    json.editOccasionLink edit_occasion_path(occasion, contact_id: occasion.contact_id)
    json.deleteOccasionLink occasion_path(occasion)
    if occasion.contact.nil?
        json.contact {}.to_json
    else
        json.contact do
            json.id occasion.contact.id
            json.name occasion.contact.family_name
            json.viewContactLink contact_path(occasion.contact_id)
            json.imagePath occasion.contact.avatar.url(:medium)
        end
    end
end