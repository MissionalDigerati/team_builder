require 'spec_helper'

describe ArchivesController, :type => :controller do
  describe "Create" do
    it "should create the backup file" do
      expect(Archive).to receive(:file_name).and_return("fred")
      post 'create' 
      expect(FileTest.exists?(Rails.root.join('backups', 'fred.tgz'))).to eq(true)
    end
  end
  
  describe "Delete" do
    it "should delete the backup file" do
      request.env['HTTP_REFERER'] = '/'
      fred = FactoryGirl.create(:archive, :filename => "delete.tgz")
      File.open(Rails.root.join('backups', 'delete.tgz'), 'w'){|f| f.write('sometext')}
      delete :destroy, :id => fred.id
      expect(FileTest.exists?(Rails.root.join('backups', 'delete.tgz'))).to eq(false)
    end
  end
end