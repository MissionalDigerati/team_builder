class ArchivesController < ApplicationController
  before_filter :occasion_summary, :only => [:index]

  def index
    @archives = Archive.all
  end
  
  #when an archive record is created it 
  def create
    name = Archive::file_name
    @archive = Archive.new(:filename => "#{name}.tgz")

    respond_to do |format|
      if @archive.save
        format.html { redirect_to archives_path, notice: 'Archive was successfully created.' }
      else
        format.html { render action: "index" }
        flash[:notice] = @archive.errors.empty? ? "Your Archive has not been saved" : "Your Archive has not been saved because: " + @archive.errors.full_messages.to_sentence
      end
    end
    path = Rails.root.join('backups', "#{name}.tgz")
    %x[rake site:backup["#{path}"]]
  end 
  
  def destroy
    @archive = Archive.find(params[:id])
    @archive.destroy
    file = Rails.root.join('backups', "#{@archive.filename}")
    if FileTest.exists?(file)
      file.delete
      flash[:notice] = "File and record has been deleted."
    else
      flash[:notice] = "Unable to locate file, however it's record has beed deleted."
    end
    redirect_to :back
  end
  
  def download
    @file = Archive.find(params[:id]).filename
    path = Rails.root.join('backups', @file)
    if FileTest.exists?(path) 
      send_file path 
    else
      redirect_to :back
      flash[:notice] = "Unable to locate file."
    end
  end
  
end