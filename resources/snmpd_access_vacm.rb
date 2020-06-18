#
# Cookbook:: net_snmp
# Resource:: snmpd_access_vacm
#
# Copyright:: Ben Hughes <bmhughes@bmhughes.co.uk>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

use 'snmpd'

include NetSnmp::Cookbook::ResourceHelpers

property :directive, [Symbol, String],
          required: true,
          equal_to: %i(com2sec com2sec6 com2secunix group view access authcommunity authuser authgroup authaccess setaccess),
          description: 'The SNMPd VACM configuration statement to declare, see snmpd.conf(5).',
          coerce: proc { |p| p.is_a?(Symbol) ? p : p.to_sym }

property :source, String,
          description: 'Source as an IPv4/IPv6 address and netmask or prefix'

property :community, String,
          description: 'SNMP community string'

property :sockpath, String,
          description: 'Socket path to use with com2secunix'

property :secname, String,
          description: 'Group security name'

property :secmodel, [Symbol, String],
          equal_to: %i(any v1 v2c usm tsm ksm),
          description: 'SNMP security model',
          coerce: proc { |p| p.is_a?(Symbol) ? p : p.to_sym }

property :view_type, [Symbol, String],
          equal_to: %i(included excluded),
          description: 'SNMP view type',
          coerce: proc { |p| p.is_a?(Symbol) ? p : p.to_sym }

property :subtree, String,
          description: 'View OID subtree base'

property :mask, String,
          description: 'View OID mask'

property :context, String,
          description: 'Access context'

property :level, String,
          description: 'Access level'

property :prefix, String,
          description: 'Access prefix'

property :read, String,
          default: 'none',
          description: 'Access read view'

property :write, String,
          default: 'none',
          description: 'Access write view'

property :notify, String,
          default: 'none',
          description: 'Access notify view'

action_class do
  include NetSnmp::Cookbook::ResourceHelpers
end

action :create do
  init_config_file_resource
  snmpd_access_property_set_valid?

  config_file_resource.variables['vacm'] ||= {}
  config_file_resource.variables['vacm'][new_resource.directive] ||= []
  config_file_resource.variables['vacm'][new_resource.directive].push(snmpd_access_property_set)
end
