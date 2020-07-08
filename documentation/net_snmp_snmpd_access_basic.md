# net_snmp_snmpd_access_basic

[Back to resource list](../README.md#resources)

Configure basic SNMP access control.

## Actions

- `:create` - Create an SNMP basic access configuration
- `:delete` - Remove an SNMP basic access configuration file

## Properties

| Name                   | Type          | Default                          | Description                                                         | Allowed Values      |
| ---------------------- | ------------- | -------------------------------- | ------------------------------------------------------------------- | ------------------- |
| `config_file`          | String        | `/etc/snmp/snmpd.conf`           | The path to the net-snmp SNMPD server configuration file on disk    |                     |
| `cookbook`             | String        | `net-snmp`                       | Cookbook to source configuration file template from                 |                     |
| `template`             | String        | `net-snmp/snmpd.conf.erb`        | Template to use to generate the configuration file                  |                     |
| `owner`                | String        | `root`                           | Owner of the generated configuration file                           |                     |
| `group`                | String        | `root`                           | Group of the generated configuration file                           |                     |
| `mode`                 | String        | `0600`                           | Filemode of the generated configuration file                        |                     |
| `directive`            | Symbol, String| None                             | Access configuration directive                                      | `:rouser, :rwuser, :rocommunity, :rwcommunity, :rocommunity6, :rwcommunity6` |
| `secmodel`             | Symbol, String| None                             | Access security model                                               | `:usm, :tsm, :ksm`  |
| `security`             | Symbol, String| None                             | Access security level                                               | `:noauth, :auth, :priv` |
| `oid`                  | String        | None                             | Access OID root restriction                                         |                     |
| `view`                 | String        | None                             | Access view restriction                                             |                     |
| `view_context`         | String        | None                             | Access view context restriction                                     |                     |
| `source`               | String        | None                             | Access source restriction                                           |                     |

## Usage

### Example - SNMPv1/v2

```ruby
net_snmp_snmpd_access_basic 'public' do
  directive :rocommunity
end
```

### Example - SNMPv3

```ruby
net_snmp_snmpd_access_user 'testuser' do
  authentication :sha
  privacy :aes
  authpassphrase 'testpass123'
  privacypassphrase 'testpass123'
end

net_snmp_snmpd_access_basic 'testuser' do
  secmodel :usm
  directive :rouser
  security :priv
end
```
