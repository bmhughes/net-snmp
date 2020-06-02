#
# Cookbook:: net_snmp
# Resource:: snmp_conf
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

use 'snmp'

property :client, Hash,
          description: 'Client SNMP default options, see snmp.conf(5)'

property :snmpv3, Hash,
          description: 'Client SNMPv3 default options, see snmp.conf(5)'

property :mib, Hash,
          description: 'Client SNMP mib options, see snmp.conf(5)'

property :output, Hash,
          description: 'Client SNMP output options, see snmp.conf(5)'

action :create do
  init_config_file_resource

  config_file_resource.variables['client'] = new_resource.client
  config_file_resource.variables['snmpv3'] = new_resource.snmpv3
  config_file_resource.variables['mib'] = new_resource.mib
  config_file_resource.variables['output'] = new_resource.output
end

action :delete do
  file new_resource.config_file do
    action :delete
  end
end
