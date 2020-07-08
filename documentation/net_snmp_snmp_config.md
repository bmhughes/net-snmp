# net_snmp_snmp_config

[Back to resource list](../README.md#resources)

Creates an SNMP client configuration file, see `snmp.conf(5)` for details.

## Actions

- `:create` - Create an SNMP client configuration file
- `:delete` - Remove an SNMP client configuration file

## Properties

| Name                   | Type          | Default                          | Description                                                         | Allowed Values      |
| ---------------------- | ------------- | -------------------------------- | ------------------------------------------------------------------- | ------------------- |
| `config_file`          | String        | `/etc/snmp/snmp.conf`            | The path to the net-snmp SNMPD client configuration file on disk    |                     |
| `cookbook`             | String        | `net-snmp`                       | Cookbook to source configuration file template from                 |                     |
| `template`             | String        | `net-snmp/snmp.conf.erb`         | Template to use to generate the configuration file                  |                     |
| `owner`                | String        | `root`                           | Owner of the generated configuration file                           |                     |
| `group`                | String        | `root`                           | Group of the generated configuration file                           |                     |
| `mode`                 | String        | `0644`                           | Filemode of the generated configuration file                        |                     |
| `client`               | Hash          | None                             | Client behaviour configuration                                      |                     |
| `snmpv3`               | Hash          | None                             | SNMPv3 client configuration                                         |                     |
| `mib`                  | Hash          | None                             | MIB handling configuration                                          |                     |
| `output`               | Hash          | None                             | Output configuration                                                |                     |

## Usage

### Example

```ruby
net_snmp_snmp_config 'snmp' do
  action :create
end
```
