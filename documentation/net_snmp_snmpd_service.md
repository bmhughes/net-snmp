# net_snmp_snmpd_service

[Back to resource list](../README.md#resources)

Configure SNMP server service.

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
| `service_name`         | String        | None                             | SystemD service name                                                |                     |
| `systemd_unit_content` | String        | Platform dependant               | SystemD unit file contents                                          |                     |
| `config_files`         | String        | Files matching glob `'/etc/snmp/snmpd.*.conf'` | Configuration files to pass to `snmpd`                |                     |

## Usage

### Example

```ruby
net_snmp_snmpd_service 'snmpd' do
  action [:create, :enable, :start]
  subscribes :restart, 'template[/etc/snmp/snmpd.conf]', :delayed
end
```
