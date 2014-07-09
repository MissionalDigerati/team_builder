class Archive < ActiveRecord::Base
  # the archive controller calls this method to generate the filename
  #
  def self.file_name
    Time.now.to_i
  end
end