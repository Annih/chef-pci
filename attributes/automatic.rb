# Provide information about PCI devices (vendor_id, device_id, class_id, ...)
automatic_attrs['pci']['devices'] = ::PCI.devices(node)

# Provide a mapping between Windows PNPIDs & PCI slots
automatic_attrs['pci']['pnp_mapping'] = node['pci']['devices'].map { |slot, device| [device['pnp_id'], slot] }.to_h if platform? 'windows'
