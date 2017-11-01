require_relative 'linux.rb'
require_relative 'windows.rb'

# Provides methods to fetch PCI information
module PCI
  unless methods.include? :devices
    def self.devices(node)
      case node['os']
      when 'windows'
        Windows.pci_devices
      when 'linux'
        Linux.pci_devices
      else
        ::Chef::Log.warn "[PCI] #{node['os']} is not a supported Operating System."
        nil
      end
    end
  end
end
