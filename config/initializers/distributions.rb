require 'fileutils'

distributions = Packager::Application.config.distributions
options = Packager::Application.config.options
base_dir = Packager::Application.config.base_dir

FileUtils.mkdir_p base_dir + "/conf"
path_distributions = base_dir + "/conf/distributions"
path_options = base_dir + "/conf/options"

puts "Distributions: #{distributions}"
puts "Options: #{options}"
puts "Base Dir: #{base_dir}"

# Create Distribution files

content_distributions = []
distributions.each do |distribution|
  content_distributions << "Origin: #{distribution['origin']}"
  content_distributions << "Label: #{distribution['label']}"
  content_distributions << "Codename: #{distribution['codename']}"
  content_distributions << "Architectures: #{distribution['architectures']}"
  content_distributions << "Components: #{distribution['components']}"
  content_distributions << "Description: #{distribution['description']}"
  if distribution['signwith']
    content_distributions << "SignWith: #{distribution['signwith']}"
  end
  content_distributions << ""
end 

content_dist = content_distributions.join("\n")

# Create Option file.
content_options = ""
options.each do |option|
  content_options += option + "\n"
end
content_options += "basedir #{base_dir}\n"

puts "Distributions==>\n#{content_dist}"
File.open(path_distributions, "wb") { |f| f.write(content_dist) }

puts "Options==>\n#{content_options}"
File.open(path_options, "wb") { |f| f.write(content_options) }

