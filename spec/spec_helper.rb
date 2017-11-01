require 'chefspec'
require 'chefspec/berkshelf'
require 'yaml'

require_relative '../libraries/default.rb'

def device_values(device_dir)
  ::YAML.load_file(::File.join(device_dir, 'values.yaml'))
end

def devices_data
  ::Dir[::File.join(__dir__, 'data', 'devices', '*')]
end
