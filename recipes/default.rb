# just to be able to test node[hostname] attribute
file '/tmp/node.hostname' do
  content node['hostname']
  mode '0755'
end
