class ChangeColumnTypeForAmountOnDonations < ActiveRecord::Migration

  def self.up
    add_column :donations, :convert_amount, :decimal, :precision => 8, :scale => 2
    
    # look up the schema's to be able to re-inspect the Donation model
    # http://apidock.com/rails/ActiveRecord/Base/reset_column_information/class
    Donation.reset_column_information
    
    # loop over the collection
    Donation.all.each do |d|
        d.convert_amount = d.amount.to_f
        d.save
    end
    
    # remove the older status column
    remove_column :donations, :amount
    # rename the convert_status to status column
    rename_column :donations, :convert_amount, :amount
  end

  def self.down
    add_column :donations, :convert_amount, :text
    
    # look up the schema's to be able to re-inspect the Donation model
    # http://apidock.com/rails/ActiveRecord/Base/reset_column_information/class
    Donation.reset_column_information
    
    # loop over the collection
    Donation.all.each do |d|
        d.convert_amount = d.amount.to_s
        d.save
    end
    
    # remove the older status column
    remove_column :donations, :amount
    # rename the convert_status to status column
    rename_column :donations, :convert_amount, :amount
  end
end
