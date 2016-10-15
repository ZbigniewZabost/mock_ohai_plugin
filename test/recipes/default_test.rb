control 'hostname of machine remains unaffected' do
  describe bash('hostname') do
    its('stdout') { should match /orginal-hostname/ }
  end
end

control 'hostname attribute in node object has mocked value' do
  describe file('/tmp/node.hostname') do
    its('content') { should match /mocked-hostname/ }
  end
end
