require 'spec_helper'

describe 'mock_ohai_plugin::default' do
  context 'When not mocking node in chefspec' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'creates file with hostname "chefspec" inside' do
      expect(chef_run).to create_file('/tmp/node.hostname').with(content: 'chefspec')
    end
  end


  context 'When mocking node in chefspec with fauxhai' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new do |node|
        node.automatic['hostname'] = 'mocked-hostname'
      end.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'creates file with hostname "mocked-hostname" inside' do
      expect(chef_run).to create_file('/tmp/node.hostname').with(content: 'mocked-hostname')
    end
  end
end
