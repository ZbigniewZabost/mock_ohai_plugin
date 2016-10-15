# Example of mocking node attributs set by ohai plugins

## In chefspec

#### Steps
Simply add ```node.automatic['hostname']``` in runner configuration:
```
let(:chef_run) do
  ChefSpec::ServerRunner.new do |node|
    node.automatic['hostname'] = 'mocked-hostname'
  end.converge(described_recipe)
end
```

## In test kitchen

#### Steps
- disable ohai plugin in ```client_rb``` configuration of provisioner:
```
provisioner:
  name: chef_zero
  client_rb:
    "Ohai::Config[:disabled_plugins] =":
      - hostname
```
- use [kitchen-ohai](https://supermarket.chef.io/cookbooks/kitchen-ohai) to set value of attribute:
```
suites:
  - name: default
    run_list:
      - recipe[kitchen-ohai]
      - recipe[my_recipe]
    verifier:
      inspec_tests:
        - test/recipes
    attributes:
      kitchen_ohai:
        values:
          hostname: "mocked-hostname"
```
