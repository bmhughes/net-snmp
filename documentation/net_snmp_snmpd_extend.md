# net_snmp_snmpd_extend

[Back to resource list](../README.md#resources)

Configure SNMP server extends.

## Actions

- `:create` - Create a SNMP server extend
- `:delete` - Remove a SNMP server extend

## Properties

| Name                   | Type          | Default                          | Description                                                         | Allowed Values      |
| ---------------------- | ------------- | -------------------------------- | ------------------------------------------------------------------- | ------------------- |
| `config_file`          | String        | `/etc/snmp/snmpd.conf`           | The path to the net-snmp SNMPD server configuration file on disk    |                     |
| `cookbook`             | String        | `net-snmp`                       | Cookbook to source configuration file template from                 |                     |
| `template`             | String        | `net-snmp/snmpd.conf.erb`        | Template to use to generate the configuration file                  |                     |
| `owner`                | String        | `root`                           | Owner of the generated configuration file                           |                     |
| `group`                | String        | `root`                           | Group of the generated configuration file                           |                     |
| `mode`                 | String        | `0600`                           | Filemode of the generated configuration file                        |                     |
| `type`                 | String, Symbol| None                             | Extend type                                                         | `:sh, :exec, :execfix, :extend, :extenfix, :pass, :pass_persist` |
| `miboid`               | String        | None                             | Extend MIB OID                                                      |                     |
| `program`              | String        | None                             | Extend executable to call                                           |                     |
| `arguments`            | String        | None                             | Arguments to pass to extend executable                              |                     |
| `priority`             | String        | None                             |                                                                     |                     |

## Usage

### Example

```ruby
nnet_snmp_snmpd_extend 'distro' do
  type :extend
  miboid '.1.3.6.1.4.1.2021.7890.1'
  program '/usr/bin/distro'
end

net_snmp_snmpd_extend 'pass_test' do
  type :pass
  miboid '.1.3.6.1.4.1.2022.7890.1'
  program '/usr/bin/pass_test'
end
```
