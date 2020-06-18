#
# Cookbook:: net_snmp
# Resource:: snmpd_access_user
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
          required: true,
          equal_to: %i(rouser rwuser rocommunity rwcommunity rocommunity6 rwcommunity6),
          description: 'Access type',
          coerce: proc { |p| p.is_a?(Symbol) ? p : p.to_sym }

property :secmodel, [Symbol, String],
          equal_to: %i(usm tsm ksm),
          description: 'Security model type',
          coerce: proc { |p| p.is_a?(Symbol) ? p : p.to_sym }

property :security, [Symbol, String],
          equal_to: %i(noauth auth priv),
          description: 'Access security level',
          coerce: proc { |p| p.is_a?(Symbol) ? p : p.to_sym }

property :oid, String,
          description: 'Restrict user to this OID root'

property :view, String,
          description: 'Restrict user to this view'

property :view_context, String,
          description: 'Restrict user to this view context'

property :source, String,
          description: 'Access source restriction'

action :create do
  init_config_file_resource

  config_file_resource.variables['basic'] ||= {}
  config_file_resource.variables['basic'][new_resource.directive] ||= []
  config_file_resource.variables['basic'][new_resource.directive].push(snmpd_access_property_set)
end
