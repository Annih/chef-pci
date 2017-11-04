require 'spec_helper.rb'

describe 'The ChefSpec patch' do
  subject { -> () { load ::File.join(__dir__, '../../libraries/_chefspec_patch.rb') } }

  context 'when not in ChefSpec context' do
    before { @chef_spec_def = ::Object.send(:remove_const, :ChefSpec) }
    after { ::Object.const_set(:ChefSpec, @chef_spec_def) }

    it 'does not read nor change the Chef Config' do
      expect(::Chef::Config).not_to receive(:anything)
      subject.call
    end
  end

  context 'when in ChefSpec context' do
    [true, false].each do |original_setting|
      context "and Chef::Config[:pci_devices_disabled] is #{original_setting}" do
        before { ::Chef::Config[:pci_devices_disabled] = original_setting }

        it 'does not change the Chef Config' do
          expect(::Chef::Config).not_to receive(:[]=)
          expect(::Chef::Config[:pci_devices_disabled]).to be original_setting

          subject.call

          expect(::Chef::Config[:pci_devices_disabled]).to be original_setting
        end
      end
    end

    context 'and Chef::Config[:pci_devices_disabled] is not set' do
      before { ::Chef::Config.delete :pci_devices_disabled }

      it 'changes the Chef Config' do
        expect(::Chef::Config[:pci_devices_disabled]).to be nil

        subject.call

        expect(::Chef::Config[:pci_devices_disabled]).to be true
      end

      it 'warns about the disable feature' do
        expect(::Chef::Log).to receive(:warn).with(/\[PCI\].*devices.*chefspec/i)

        subject.call
      end
    end
  end
end
