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

      it 'calls ::PCI::Windows.pci_devices and returns its result' do
        result = double(:result)
        expect(::PCI::Windows).to receive(:pci_devices).and_return result

        expect(::PCI.devices(node)).to be result
      end
    end

    context 'on a non supported OS' do
      before { node.automatic['os'] = 'mac_os_x' }

      it 'warns about the non-support' do
        expect(::Chef::Log).to receive(:warn).with('[PCI] mac_os_x is not a supported Operating System.')

        ::PCI.devices node
      end

      it 'returns nil' do
        expect(::PCI.devices(node)).to be nil
      end
    end
  end
end
