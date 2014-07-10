namespace :vendor_tasks do
  
  desc "Convert the url(../images), url(./images), url(/images), and url(images) to to SASS asset-url(folder name) in the vendor directory of the stylesheets"
  task :sassify do |t, args|
    current_image_path_name = 'images'
    path_seperator = File.join( "", "")
    root_relative_path = File.join('..', '..','..')
    root_dir = File.expand_path(root_relative_path, __FILE__)
    stylesheets_dir = File.expand_path(File.join(root_relative_path, 'vendor', 'assets', 'stylesheets'), __FILE__)
    bash_script = File.join(root_dir, 'bin', 'sassify')

    Dir["#{stylesheets_dir}/**/*.css"].each do |file|
      sass_file = "#{file}.scss"
      vendor_file_dir = file.gsub(stylesheets_dir, "")
      # The first item is a dir seperator
      image_path_dir = vendor_file_dir.split(path_seperator)[1]
      cmd = "#{bash_script} #{current_image_path_name} #{image_path_dir} #{file}"
      system(cmd)
      puts "converted #{File.basename(file)} to #{File.basename(sass_file)} with the SASS helper methods."
      File.delete(file)
    end
  end

end