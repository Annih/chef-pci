require 'spec_helper.rb'

describe 'pci::default' do
  let(:attributes) { ::Chef::Node::VividMash.new }
  let(:chef_run) do
    ::ChefSpec::SoloRunner.new(platform: platform, version: platform_version) do |node|
      node.normal = attributes
    end.converge(described_recipe)
  end

  { CentOS: '7.4.1708', Windows: '2016' }.each do |platform, platform_version|
    context "on #{platform} #{platform_version}" do
      let(:platform) { platform.to_s.downcase }
      let(:platform_version) { platform_version }

      context 'with default attributes' do
        it 'converges successfully' do
          skip('Not supported on non-Windows machine.') if platform == :Windows && RUBY_PLATFORM !~ /mswin|mingw32|windows/
          chef_run
        end
      end
    end
  end
end
