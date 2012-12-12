class ArchivesController < ApplicationController
  before_filter :occasion_summary, :only => [:index]
  def index
    @archives = Archive.all
  end
  
  def create
    name = Time.now.to_i
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
    respond_to do |format|
      format.html { redirect_to :back }
      flash[:notice] = "Your archive has been deleted."
    end
    file = Rails.root.join('backups', "#{@archive.filename}").delete
  end
  
end