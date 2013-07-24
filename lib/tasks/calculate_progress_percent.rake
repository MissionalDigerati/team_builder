
namespace :db do
  
  desc "It will take all of the existing support states, and create a supportstate "
  task :support_update => :environment do
    SupportState.all.each do |state|
      state.update_attributes(progress_percent: 0)
    end
  end
end