desc "Run all specs"
task :spec do
  dir = File.expand_path(File.dirname(__FILE__) + '/spec')
  Dir[File.expand_path("#{dir}/**/*.rb")].uniq.each do |file|
    require file unless file.include?("helper")
  end
end