#!/usr/bin/env ruby

if ENV["PROJECT_NAME"].nil?
  puts "Try $ PROJECT_NAME=<NewProjectName> osx_init.rb"
  exit 1
end


name = ENV["PROJECT_NAME"]
puts "Initializing project '#{name}'"

# From: http://stackoverflow.com/a/1509939/316700
class String
  def underscore
    self.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
  end
end

def shell(command)
  puts "Executing: #{command}"
  result = Kernel.system command
  raise Exception, "Command error" if !result
end

shell "git clone --depth=1 git@github.com:fguillen/Skeleton.git #{name}"
shell "rm -rf #{name}/.git"
shell "find ./#{name}/ -type f ! -name '*_init.rb' | xargs grep 'skeleton' | cut -f1 -d':' | xargs sed -i '' -e 's/skeleton/#{name.underscore}/'"
shell "find ./#{name}/ -type f ! -name '*_init.rb' | xargs grep 'Skeleton' | cut -f1 -d':' | xargs sed -i '' -e 's/Skeleton/#{name}/'"
shell "mv #{name}/lib/tasks/skeleton.rake #{name}/lib/tasks/#{name.underscore}.rake"