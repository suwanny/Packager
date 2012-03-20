# Load the rails application
require File.expand_path('../application', __FILE__)

Packager::Application.configure do
  package = YAML::load_file "#{config.root}/config/package.yml"
  # puts package.inspect
  config.auth_key = package["auth_key"]
  config.distributions = package["distributions"]
  config.options = package["options"]
  config.base_dir = File.expand_path('../../', __FILE__) + "/public/" + package["base_dir"]
  config.base_name = package["base_dir"]
  
  cmd_reprepro = `which reprepro`
  config.reprepro = cmd_reprepro.size > 0 ? cmd_reprepro : nil
end

# Initialize the rails application
Packager::Application.initialize!

