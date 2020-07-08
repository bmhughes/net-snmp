# net_snmp_snmpd_override

[Back to resource list](../README.md#resources)

Configure SNMP server overrides.

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
| `rw`                   | `true`, `false` | `false`                        | Allow SNMP set on override                                          |                     |
| `oid`                  | String        | None                             | OID to override                                                     |                     |
| `type`                 | String        | None                             | Override OID file type                                              |                     |
| `value`                | String        | None                             | Override value                                                      |                     |

## Usage

### Example

```ruby
net_snmp_snmpd_override 'sysDescr.0' do
  type 'octet_str'
  value 'Overriden sysDescr'
end
```
