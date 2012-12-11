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
    %x[rake site:backup[../team_builder/backups/"#{name}".tgz]]
  end 
end