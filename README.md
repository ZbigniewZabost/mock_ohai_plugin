# mock_ohai_plugin

Example of mocking node attributs set by ohai plugin during kitchen tests.

## Steps
- disable ohai plugin in ```client_rb``` configuration of provisioner, e.g.:
```
provisioner:
  name: chef_zero
  client_rb:
    "Ohai::Config[:disabled_plugins] =":
      - hostname
```
- use [kitchen-ohai](https://supermarket.chef.io/cookbooks/kitchen-ohai) to set needed value on given attribute, e.g.:
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
