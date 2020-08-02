# net_snmp

[![Pipeline Status](https://gitlab.bmhughes.co.uk/bmhughes-net-chef/cookbooks/net_snmp/badges/master/pipeline.svg)](https://gitlab.bmhughes.co.uk/bmhughes-net-chef/cookbooks/net_snmp/-/commits/master) [![Coverage Report](https://gitlab.bmhughes.co.uk/bmhughes-net-chef/cookbooks/net_snmp/badges/master/coverage.svg)](https://gitlab.bmhughes.co.uk/bmhughes-net-chef/cookbooks/net_snmp/-/commits/master)

## Change Log

- See [CHANGELOG.md](/CHANGELOG.md) for version details and changes.

## Requirements

See the following documentation for information on how to configure net-snmp

- [snmp.conf](http://www.net-snmp.org/docs/man/snmp.conf.html)
- [snmpd.conf](http://www.net-snmp.org/docs/man/snmpd.conf.html)

### Platforms

The following platforms are supported and tested with Test Kitchen:

- RHEL/CentOS 7+
- Ubuntu 18.04+
- Debian 10

## Resources

The following resources are provided:

- [net_snmp_package](documentation/net_snmp_package.md)
- [net_snmp_snmp_config](documentation/net_snmp_snmp_config.md)
- [net_snmp_snmpd_config](documentation/net_snmp_snmpd_config.md)
- [net_snmp_snmpd_access_basic](documentation/net_snmp_snmpd_access_basic.md)
- [net_snmp_snmpd_access_user](documentation/net_snmp_snmpd_access_user.md)
- [net_snmp_snmpd_access_vacm](documentation/net_snmp_snmpd_access_vacm.md)
- [net_snmp_snmpd_extend](documentation/net_snmp_snmpd_extend.md)
- [net_snmp_snmpd_override](documentation/net_snmp_snmpd_override.md)
- [net_snmp_snmpd_proxy](documentation/net_snmp_snmpd_proxy.md)
- [net_snmp_snmpd_service](documentation/net_snmp_snmpd_service.md)
