unless ::Chef::Config[:pci_devices_disabled]
  automatic_attrs['pci'] = Mash.new if automatic_attrs['pci'].nil?
  # Provide information about PCI devices (vendor_id, device_id, class_id, ...)
  automatic_attrs['pci']['devices'] = ::PCI.devices(node)

  # Provide a mapping between Windows PNPIDs & PCI slots
  automatic_attrs['pci']['pnp_mapping'] = ::PCI.pnp_mapping(node) if platform? 'windows'
end
