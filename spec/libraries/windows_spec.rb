require_relative '../../libraries/windows.rb'

describe ::PCI::Windows do
  describe 'the method #pnp_info' do
    it 'parses ids correctly' do
      hardware_ids = %w[PCI\VEN_8086&DEV_9C10&SUBSYS_060A1028&REV_E4
                        PCI\VEN_8086&DEV_9C10&SUBSYS_060A1028
                        PCI\VEN_8086&DEV_9C10&CC_060400
                        PCI\VEN_8086&DEV_9C10&CC_0604]
      expect(::PCI::Windows.pnp_info(hardware_ids)).to eq('vendor_id' => '8086', 'device_id' => '9c10',
                                                          'sdevice_id' => '060a', 'svendor_id' => '1028',
                                                          'class_id' => '0604', 'rev' => 'e4',)
    end
  end

  describe 'the method #slot' do
    it 'converts location string into pci slot' do
      location_string = '@System32\drivers\pci.sys,#65536;PCI bus %1, device %2, function %3;(0,28,0)'
      expect(::PCI::Windows.slot(location_string)).to eq '0000:00:1c.0'
    end

    it 'raises an error when location string is invalid' do
      expect { ::PCI::Windows.slot('toto') }.to raise_error '[PCI] Invalid location string: \'toto\''
    end
  end
end
