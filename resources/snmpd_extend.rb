#
# Cookbook:: net_snmp
# Resource:: snmpd_extend
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

property :type, [String, Symbol],
          equal_to: %i(sh exec execfix extend extendfix pass pass_persist),
          description: 'Extend method to use',
          coerce: proc { |p| p.is_a?(Symbol) ? p : p.to_sym }

property :miboid, String

property :program, String

property :arguments, String

property :priority, String

action :create do
  init_config_file_resource

  config_file_resource.variables['extend'] ||= {}
  config_file_resource.variables['extend'][new_resource.type] ||= []
  config_file_resource.variables['extend'][new_resource.type].push(resource_property_set)
end
