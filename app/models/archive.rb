class Archive < ActiveRecord::Base
  attr_accessible :filename
  
  def self.file_name
    Time.now.to_i
  end
end