require 'xcodeproj'
require 'json'

project_file_name = nil
project_files = Dir.entries('./ios')
project_files.to_a.map do |file|
  if File.extname(file) == '.xcodeproj' then
    project_file_name = file
  end
end

project_path = './ios/' + project_file_name
project = Xcodeproj::Project.open(project_path)
target = project.targets.first

project.main_group.new_file('../node_modules/react-native-navitia-sdk/RNNavitiaSDK/RNNavitiaSDK.h')
target.add_file_references([
  project.main_group.new_file('../node_modules/react-native-navitia-sdk/RNNavitiaSDK/RNNavitiaSDK.m')
])

source_files = target.source_build_phase.files.to_a.map do |pbx_build_file|
  pbx_build_file.file_ref.real_path.to_s
end

puts 'Source files in Xcode project:'
puts source_files

project.save(project_path)

if not File.exist?('./ios/Podfile') then
  system "cd ios && pod init"
end

packageFile = File.open('./node_modules/react-native-navitia-sdk/package.json').read
packageData = JSON.parse(packageFile.to_s)
version = packageData['version']

File.open('./ios/Podfile', 'a+') do |file|
  file.puts "\r" + "use_frameworks!"
  file.puts "\r" + "pod 'NavitiaSDK', '" + version + "'"
end

system "cd ios && pod install"