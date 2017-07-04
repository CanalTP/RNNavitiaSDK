require 'xcodeproj'
require 'json'

platform_path = '../../ios'

project_file_name = nil
project_files = Dir.entries(platform_path)
project_files.to_a.map do |file|
  if File.extname(file) == '.xcodeproj' then
    project_file_name = file
  end
end

project_path = platform_path + '/' + project_file_name
project = Xcodeproj::Project.open(project_path)
target = project.targets.first

project.main_group.new_file('../node_modules/react-native-navitia-sdk/RNNavitiaSDK/RNNavitiaSDK.h')
target.add_file_references([
  project.main_group.new_file('../node_modules/react-native-navitia-sdk/RNNavitiaSDK/RNNavitiaSDK.m')
])

project.save(project_path)

if not File.exist?(platform_path + '/Podfile') then
  system 'cd ' + platform_path + ' && pod init'
end

File.open(platform_path + '/Podfile', 'a+') do |file|
  file.puts "\r" + "use_frameworks!"
  file.puts "\r" + "pod 'NavitiaSDK', '0.1'"
end

system 'cd ' + platform_path + ' && pod install'