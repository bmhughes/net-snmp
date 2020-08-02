# net_snmp_package

[Back to resource list](../README.md#resources)

## Actions

- `:install`
- `:upgrade`
- `:remove`

## Properties

| Name                   | Type          | Default                          | Description                                                         | Allowed Values      |
| ---------------------- | ------------- | -------------------------------- | ------------------------------------------------------------------- | ------------------- |
| `packages`             | String, Array | Platform dependant               | Packages to install                                                 |                     |

## Usage

By default the resource will install all net-snmp packages for the platform, use the `packages` property to override the default list.

### Default installation

```ruby
net_snmp_package '' do
  action :install
end
```

### Install with overriden packages

```ruby
net_snmp_package '' do
  packages %w(snmpd)
  action :install
end
```
