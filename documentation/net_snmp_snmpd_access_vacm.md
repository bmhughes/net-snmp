# net_snmp_snmpd_access_vacm

[Back to resource list](../README.md#resources)

Configure VACM SNMP access control.

## Actions

- `:create` - Create an SNMP VACM access configuration
- `:delete` - Remove an SNMP VACM access configuration

## Properties

| Name                   | Type          | Default                          | Description                                                         | Allowed Values      |
| ---------------------- | ------------- | -------------------------------- | ------------------------------------------------------------------- | ------------------- |
| `config_file`          | String        | `/etc/snmp/snmpd.conf`           | The path to the net-snmp SNMPD server configuration file on disk    |                     |
| `cookbook`             | String        | `net-snmp`                       | Cookbook to source configuration file template from                 |                     |
| `template`             | String        | `net-snmp/snmpd.conf.erb`        | Template to use to generate the configuration file                  |                     |
| `owner`                | String        | `root`                           | Owner of the generated configuration file                           |                     |
| `group`                | String        | `root`                           | Group of the generated configuration file                           |                     |
| `mode`                 | String        | `0600`                           | Filemode of the generated configuration file                        |                     |
| `directive`            | Symbol, String| None                             | Access configuration directive                                      | `:com2sec, :com2sec6, :com2secunix, :group, :view, :access, :authcommunity, :authuser, :authgroup, :authaccess, :setaccess` |
| `source`               | String        | None                             |                                                                     |                     |
| `community`            | String        | None                             |                                                                     |                     |
| `sockpath`             | String        | None                             |                                                                     |                     |
| `secname`              | String        | None                             |                                                                     |                     |
| `secmodel`             | String, Symbol| None                             |                                                                     | `:any, :v1, :v2c, :usm, :tsm, :ksm` |
| `view_type`            | String, Symbol| None                             |                                                                     | `:included, :excluded` |
| `subtree`              | String        | None                             |                                                                     |                     |
| `mask`                 | String        | None                             |                                                                     |                     |
| `context`              | String        | None                             |                                                                     |                     |
| `level`                | String        | None                             |                                                                     |                     |
| `prefix`               | String        | None                             |                                                                     |                     |
| `read`                 | String        | None                             |                                                                     |                     |
| `write`                | String        | None                             |                                                                     |                     |
| `notify`               | String        | None                             |                                                                     |                     |

## Usage

### Example

```ruby
net_snmp_snmpd_access_vacm 'notConfigUser' do
  directive :com2sec
  source 'default'
  community 'public'

  action :create
end

net_snmp_snmpd_access_vacm 'notConfigGroup' do
  directive :group
  secmodel :v1
  secname 'notConfigUser'

  action :create
end

net_snmp_snmpd_access_vacm 'notConfigGroup' do
  directive :group
  secmodel :v2c
  secname 'notConfigUser'

  action :create
end

net_snmp_snmpd_access_vacm 'systemview' do
  directive :view
  view_type :included
  subtree '.1.3.6.1.2.1.1'

  action :create
end

net_snmp_snmpd_access_vacm 'systemview' do
  directive :view
  view_type :included
  subtree '.1.3.6.1.2.1.25.1.1'

  action :create
end

net_snmp_snmpd_access_vacm 'notConfigGroup-read-systemview' do
  directive :access
  group 'notConfigGroup'
  context '""'
  secmodel :any
  level 'noauth'
  prefix 'exact'
  read 'systemview'

  action :create
end
```
