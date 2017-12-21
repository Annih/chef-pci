require 'spec_helper.rb'

describe 'The cookbook pci' do
  let(:chef_run) do
    ::ChefSpec::SoloRunner.new(platform: platform, version: platform_version).converge('pci')
  end

  { CentOS: '7.4.1708', Windows: '2016' }.each do |platform, platform_version|
    context "on #{platform} #{platform_version}" do
      let(:platform) { platform.to_s.downcase }
      let(:platform_version) { platform_version }

      context 'when ::Chef::Config[:pci_devices_disabled] is truthy' do
        before { ::Chef::Config[:pci_devices_disabled] = true }

        it 'does not load pci devices attributes' do
          expect(::PCI).not_to receive(:devices)
          expect(chef_run.node.automatic['pci']).not_to have_key 'devices'
        end
        it 'does not load pnp mapping' do
          expect(::PCI).not_to receive(:pnp_mapping)
          expect(chef_run.node.automatic['pci']).not_to have_key 'pnp_mapping'
        end
      end

      context 'when ::Chef::Config[:pci_devices_disabled] is false' do
        before { ::Chef::Config[:pci_devices_disabled] = false }

        it 'loads pci devices as an Automatic attribute: pci.devices' do
          result = double.as_null_object
          expect(::PCI).to receive(:devices).at_least(:once).and_return result
          expect(chef_run.node.automatic['pci']['devices']).to be result
        end

        if platform == :Windows
          it 'loads pnp mapping as an Automatic attribute: pci.pnp_mapping' do
            result = double.as_null_object
            expect(::PCI).to receive(:devices).and_return result
            expect(::PCI).to receive(:pnp_mapping).and_return result

            expect(chef_run.node.automatic['pci']['pnp_mapping']).to be result
          end
        end
      end
    end
  end
end
