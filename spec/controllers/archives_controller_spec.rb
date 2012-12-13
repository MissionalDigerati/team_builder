require 'spec_helper'

describe ArchivesController do
  describe "Create" do
    it "should create the backup file" do
      Archive.should_receive(:file_name).and_return("fred")
      post 'create' 
      FileTest.exists?(Rails.root.join('backups', 'fred.tgz')).should == true
    end
  end
  
  describe "Delete" do
    it "should delete the backup file" do
      request.env['HTTP_REFERER'] = '/'
      fred = FactoryGirl.create(:archive, :filename => "delete.tgz")
      File.open(Rails.root.join('backups', 'delete.tgz'), 'w'){|f| f.write('sometext')}
      delete :destroy, :id => fred.id
      FileTest.exists?(Rails.root.join('backups', 'delete.tgz')).should == false
    end
  end
end