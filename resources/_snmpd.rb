#
# Cookbook:: net_snmp
# Resource:: _snmpd (Partial)
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

include NetSnmp::Cookbook::GeneralHelpers

property :config_file, String,
          default: lazy { "#{snmp_config_dir}/#{snmpd_config_file}" },
          description: 'The path to the snmpd configuration on disk'

property :cookbook, String,
          default: 'net_snmp',
          description: 'Cookbook to source configuration file template from'

property :template, String,
          default: 'net-snmp/snmpd.conf.erb',
          description: 'Template to use to generate the configuration file'

property :owner, String,
          default: lazy { default_net_snmp_user },
          description: 'Owner of the generated configuration file'

property :group, String,
          default: lazy { default_net_snmp_group },
          description: 'Group of the generated configuration file'

property :mode, String,
          default: '0600',
          description: 'Filemode of the generated configuration file'

action_class do
  include NetSnmp::Cookbook::ResourceHelpers
end

default_action :create
