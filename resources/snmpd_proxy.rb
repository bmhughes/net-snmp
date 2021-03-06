#
# Cookbook:: net_snmp
# Resource:: snmpd_proxy
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

property :context, String

property :snmp_command_arguments, String

property :host, String

property :oid, String

property :remote_oid, String

action :create do
  init_config_file_resource

  config_file_resource.variables['proxy'] ||= []
  config_file_resource.variables['proxy'].push(resource_property_set)
end
