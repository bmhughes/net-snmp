#
# Cookbook:: net_snmp
# Resource:: snmpd_conf
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

property :agent, Hash,
          default: lazy { snmpd_default_config(:agent) },
          description: 'Agent SNMPd configuration'

property :agentx, Hash,
          default: lazy { snmpd_default_config(:agentx) },
          description: 'AgentX SNMPd configuration'

property :dtls, Hash,
          description: 'DTLS SNMPd configuration'

property :engine, Hash,
          description: 'SNMPv3 engine configuration'

property :logging, Hash,
          default: lazy { snmpd_default_config(:logging) },
          description: 'Logging SNMPd configuration'

property :system, Hash,
          default: lazy { snmpd_default_config(:system) },
          description: 'System SNMPd configuration'

property :dlmod, Hash,
          description: 'Dynamically loadable modules'

property :additional_parameters, Hash,
          description: 'Additional configuration options'

property :additional_config_files, Array,
          description: 'Additional configuration files to include'

action :create do
  init_config_file_resource

  unless nil_or_empty?(new_resource.additional_config_files)
    node.run_state['snmpd_config_files'] ||= []
    node.run_state['snmpd_config_files'].push(new_resource.config_file) unless node.run_state['snmpd_config_files'].include?(new_resource.config_file)
  end

  config_file_resource.variables['agent'] = new_resource.agent
  config_file_resource.variables['agent'] = new_resource.agent
  config_file_resource.variables['agentx'] = new_resource.agentx
  config_file_resource.variables['dtls'] = new_resource.dtls
  config_file_resource.variables['engine'] = new_resource.engine
  config_file_resource.variables['logging'] = new_resource.logging
  config_file_resource.variables['system'] = new_resource.system
  config_file_resource.variables['dlmod'] = new_resource.dlmod
  config_file_resource.variables['additional_parameters'] = new_resource.additional_parameters
end

action :delete do
  file new_resource.config_file do
    action :delete
  end
end
