#
# Cookbook:: net_snmp
# Resource:: snmpd_override
#
# Copyright:: 2020, Ben Hughes
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

property :rw, [true, false],
          default: false,
          description: 'Allow SNMP Set on override'

property :oid, String,
          name_property: true,
          description: 'The OID to override'

property :type, String,
          description: 'The OID type to override, see snmpd.conf(5) for valid types'

property :value, [String, Integer, Float],
          description: 'The value to override with',
          coerce: proc { |p| p.is_a?(String) ? "\"#{p}\"" : p }

action :create do
  init_config_file_resource

  config_file_resource.variables['override'] ||= {}
  config_file_resource.variables['override'][new_resource.oid] = resource_property_set
end

action :delete do
  init_config_file_resource

  unless nil_or_empty?(config_file_resource.variables['override'])
    config_file_resource.variables['override'].delete(new_resource.oid)
  end
end
