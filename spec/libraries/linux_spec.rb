require 'spec_helper.rb'
require_relative '../../libraries/linux.rb'

describe ::PCI::Linux do
  describe 'the method #read_values' do
    it 'parses pci ids correctly from config space' do
      devices_data.each { |file| expect(::PCI::Linux.read_values(file)). to eq device_values(file) }
    end
  end
end
