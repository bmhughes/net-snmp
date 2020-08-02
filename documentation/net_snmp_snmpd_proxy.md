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
| `context`              | String        | None                             |                                                                     |                     |
| `snmp_command_arguments` | String      | None                             | Argument to use when retrieving SNMP value from target host         |                     |
| `host`                 | String        | None                             | Host to send SNMP request to                                        |                     |
| `oid`                  | String        | None                             | Local OID for proxied value                                         |                     |
| `remote_oid`           | String        | None                             | Remote OID to proxy                                                 |                     |

## Usage

### Example

```ruby
net_snmp_snmpd_proxy 'Test Proxy' do
  host '127.0.0.127'
  oid '.1.2.3'
end
```
