# net_snmp_snmpd_config

[Back to resource list](../README.md#resources)

Creates an SNMP server configuration file, see `snmpd.conf(5)` for details.

## Actions

- `:create` - Create an SNMP client configuration file
- `:delete` - Remove an SNMP client configuration file

## Properties

| Name                   | Type          | Default                          | Description                                                         | Allowed Values      |
| ---------------------- | ------------- | -------------------------------- | ------------------------------------------------------------------- | ------------------- |
| `config_file`          | String        | `/etc/snmp/snmpd.conf`           | The path to the net-snmp SNMPD server configuration file on disk    |                     |
| `cookbook`             | String        | `net-snmp`                       | Cookbook to source configuration file template from                 |                     |
| `template`             | String        | `net-snmp/snmpd.conf.erb`        | Template to use to generate the configuration file                  |                     |
| `owner`                | String        | `root`                           | Owner of the generated configuration file                           |                     |
| `group`                | String        | `root`                           | Group of the generated configuration file                           |                     |
| `mode`                 | String        | `0600`                           | Filemode of the generated configuration file                        |                     |
| `agent`                | Hash          | Redhat default configuration     | Agent behaviour configuration                                       |                     |
| `agentx`               | Hash          | Redhat default configuration     | AgentX master/subagent configuration                                |                     |
| `dtls`                 | Hash          | None                             | SNMPv3 DTLS configuration                                           |                     |
| `engine`               | Hash          | None                             | SNMPv3 engine configuration                                         |                     |
| `logging`              | Hash          | Redhat default configuration     | Logging configuration                                               |                     |
| `system`               | Hash          | Redhat default configuration     | System group configuration                                          |                     |
| `dlmod`                | Hash          | None                             | Dynamic loadable module support configuration                       |                     |
| `additional_parameters`| Hash          | None                             | Additional arbitrary configuration directives                       |                     |
| `additional_config_files` | Hash       | None                             | Additional configuration files to include                           |                     |

## Usage

All properties are optional and by default the settings in the generated configuration will be a Redhat-style default SNMP setup.

### Example

```ruby
net_snmp_snmpd_config 'snmp' do
  action :create
end
```
