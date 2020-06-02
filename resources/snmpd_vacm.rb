#
# Cookbook:: net_snmp
# Resource:: snmpd_vacm
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

property :directive, [Symbol, String],
          equal_to: %i(com2sec com2sec6 com2secunix group view access),
          description: 'The SNMPd VACM configuration statement to declare, see snmpd.conf(5).',
          coerce: proc { |p| p.is_a?(Symbol) ? p : p.to_sym }

property :secname, String,
          description: 'Security name'

property :source, String,
          description: 'Source as an IPv4/IPv6 address and netmask or prefix'

property :community, String,
          descirption: 'SNMP community string'

property :sockpath, String,
          description: 'Socket path to use with com2secunix'

property :group, String,
          description: 'Group name string'

property :security_model, [Symbol, String],
          equal_to: %i(v1 v2c usm tsm ksm),
          description: 'SNMP security model',
          coerce: proc { |p| p.is_a?(Symbol) ? p : p.to_sym }

property :view, String,
          description: 'SNMP view name'

property :view_type, [Symbol, String],
          equal_to: %i(included excluded),
          description: 'SNMP view type',
          coerce: proc { |p| p.is_a?(Symbol) ? p : p.to_sym }

property :oid, String,
          description: 'View OID tree base'

property :mask, String,
          description: 'View OID mask'

property :context, String,
          description: 'Access context'

property :level, String,
          description: 'Access level'

property :prefix, String,
          description: 'Access prefix'

property :read, String,
          description: 'Access read view'

property :write, String,
          description: 'Access write view'

property :notify, String,
          description: 'Access notify view'

action :create do
  #stuff
end
