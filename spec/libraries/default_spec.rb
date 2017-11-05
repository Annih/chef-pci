require 'spec_helper.rb'

describe '::PCI.devices' do
  subject { -> () { ::PCI.devices(node) } }
  let(:node) { ::Chef::Node.new }

  context 'on a Linux node' do
    before { node.automatic['os'] = 'linux' }

    it 'calls ::PCI::Linux.pci_devices and returns its result' do
      result = double(:result)
      expect(::PCI::Linux).to receive(:pci_devices).and_return result

      expect(subject.call).to be result
    end
  end

  context 'on a Windows node' do
    before { node.automatic['os'] = 'windows' }

    it 'calls ::PCI::Windows.pci_devices and returns its result' do
      result = double(:result)
      expect(::PCI::Windows).to receive(:pci_devices).and_return result

      expect(subject.call).to be result
    end
  end

  context 'on a non supported OS' do
    before { node.automatic['os'] = 'mac_os_x' }

    it 'warns about the non-support' do
      expect(::Chef::Log).to receive(:warn).with('[PCI] mac_os_x is not a supported Operating System.')

      subject.call
    end

    it 'returns nil' do
      expect(subject.call).to be nil
    end
  end
end

describe '::PCI.pnp_mapping' do
  subject { -> () { ::PCI.pnp_mapping(node) } }
  let(:node) { ::Chef::Node.new }

  context 'on a Windows node' do
    before { node.automatic['os'] = 'windows' }
    cached(:devices) { all_devices(true) }

    shared_examples 'pnp_mapping' do
      it 'computes the pnp mapping' do
        mapping = ::Mash.new('PCI\VEN_8086&DEV_2415&SUBSYS_01771028&REV_01\3&11583659&0E0': '0000:00:00.0',
                             'PCI\VEN_1AF4&DEV_1000&SUBSYS_00011AF4&REV_00\3&267a616&1&18': '0000:00:01.0',)
        expect(::PCI.pnp_mapping(node)).to eq mapping
      end
    end

    context 'when node[pci][devices] is undefined' do
      before { allow(::PCI::Windows).to receive(:pci_devices).and_return devices }

      it 'calls ::PCI::Windows.pci_devices' do
        expect(::PCI::Windows).to receive(:pci_devices)
        ::PCI.pnp_mapping(node)
      end

      include_examples 'pnp_mapping'
    end

    context 'when node[pci][devices] is set' do
      before { node.automatic['pci']['devices'] = devices }

      it 'does not call ::PCI::Windows.pci_devices' do
        expect(::PCI::Windows).not_to receive(:pci_devices)
        ::PCI.pnp_mapping(node)
      end

      include_examples 'pnp_mapping'
    end
  end

  context 'on a non-Windows node' do
    it 'raise an error because it is not supported' do
      %w[linux mac_os_x].each do |os|
        node.automatic['os'] = os
        expect { ::PCI.pnp_mapping(node) }.to raise_error(/only available on windows/i)
      end
    end
  end
end
