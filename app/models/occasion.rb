class Occasion < ActiveRecord::Base
    belongs_to :contact
    attr_accessible :occasion, :contact_id, :special_date
    acts_as_birthday :special_date

    def calendar_date
        Date.parse("#{Date.today.year}-#{self.special_date.month}-#{self.special_date.day}")
    end
end