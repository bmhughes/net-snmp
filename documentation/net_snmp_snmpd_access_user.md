# net_snmp_snmpd_access_user

[Back to resource list](../README.md#resources)

Configure a SNMP user.

## Actions

- `:create` - Create an SNMP user
- `:delete` - Remove an SNMP user

## Properties

| Name                   | Type          | Default                          | Description                                                         | Allowed Values      |
| ---------------------- | ------------- | -------------------------------- | ------------------------------------------------------------------- | ------------------- |
| `config_file`          | String        | `/etc/snmp/snmpd.users.conf`     | The path to the net-snmp SNMPD server user file on disk             |                     |
| `cookbook`             | String        | `net-snmp`                       | Cookbook to source configuration file template from                 |                     |
| `template`             | String        | `net-snmp/snmpd.users.conf.erb`  | Template to use to generate the configuration file                  |                     |
| `sensitive`            | `true`, `false` | `true`                         | Template to use to generate the configuration file                  |                     |
| `owner`                | String        | `root`                           | Owner of the generated configuration file                           |                     |
| `group`                | String        | `root`                           | Group of the generated configuration file                           |                     |
| `mode`                 | String        | `0600`                           | Filemode of the generated configuration file                        |                     |
| `directive`            | Symbol, String| `:createuser`                    | User configuration directive                                        | `:createuser`       |
| `authentication`       | Symbol, String| None                             | SNMPv3 authentication type                                          | `:md5, :sha`        |
| `privacy`              | Symbol, String| None                             | SNMPv3 privacy type                                                 | `:des, :aes`        |
| `authpassphrase`       | String        | None                             | SNMPv3 authentication passphrase                                    |                     |
| `privacypassphrase`    | String        | None                             | SNMPv3 privacy passphrase                                           |                     |
| `engineid`             | String        | None                             | Override the SNMPv3 engine ID                                       |                     |

## Usage

### Example

```ruby
net_snmp_snmpd_access_user 'testuser' do
  authentication :sha
  privacy :aes
  authpassphrase 'testpass123'
  privacypassphrase 'testpass123'
end
```
