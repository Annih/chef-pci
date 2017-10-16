require 'chef/mash'

module PCI
  # Provides methods to fetch PCI information on Linux
  module Linux
    def self.slot(device_path)
      ::File.basename device_path
    end

    # Read a PCI value from sysFS
    def self.read_value(path, component, digits = 4)
      file = ::File.join(path, component)
      ::File.read(file).gsub(/^0x(\h{#{digits}}).*$/, '\1') if ::File.exist? file
    end

    # Retrieve all available PCI devices info
    def self.pci_devices
      ::Mash.new.tap do |result|
        ::Dir['/sys/bus/pci/devices/*'].each do |device_path|
          result[slot(device_path)] = ::Mash.new(
            vendor_id:  read_value(device_path, 'vendor'),
            svendor_id: read_value(device_path, 'subsystem_vendor'),
            device_id:  read_value(device_path, 'device'),
            sdevice_id: read_value(device_path, 'subsystem_device'),
            class_id:   read_value(device_path, 'class'),
            # Revision is not available via SysFS on Kernel < 4.10
            rev:        read_value(device_path, 'revision', 2),
          )
        end
      end
    end
  end
end
