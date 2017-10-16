# Provides methods to fetch PCI information
module PCI
  def self.devices(node)
    case node['os']
    when 'windows'
      require_relative 'windows.rb'
      Windows.pci_devices
    when 'linux'
      require_relative 'linux.rb'
      Linux.pci_devices
    else
      ::Chef::Log.warn "[PCI] #{node['os']} is not a supported Operating System."
      nil
    end
  end
end
