require 'chefspec'
require 'chefspec/berkshelf'
require 'yaml'

require_relative '../libraries/default.rb'

def device_values(device_dir)
  ::YAML.load_file(::File.join(device_dir, 'values.yaml'))
end

def device_pnp_id(device_dir)
  ::File.read(::File.join(device_dir, 'pnp_id'))
end

def devices_data
  ::Dir[::File.join(__dir__, 'data', 'devices', '*')]
end

def all_devices(pnp_id = false)
  ::Mash.new.tap do |result|
    devices_data.each_with_index do |path, index|
      slot = "0000:00:#{index.to_s.rjust(2, '0')}.0"
      result[slot] = device_values(path)
      result[slot].merge!(pnp_id: device_pnp_id(path)) if pnp_id
    end
  end
end

::RSpec.configure do |config|
  # Specify the Chef log_level (default: :warn)
  ::Chef::Log.level(config.log_level = :fatal)
  config.before do
    # Reset the chef config before every check
    # This helps to ensure libraries code is properly tested
    ::Chef::Config[:pci_devices_disabled] = false
  end
end
