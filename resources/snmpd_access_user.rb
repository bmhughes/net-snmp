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

property :config_file, String,
          default: lazy { "#{snmp_config_dir}/#{snmpd_config_user_file}" },
          description: 'The path to the snmpd user configuration on disk'

property :template, String,
          default: 'net-snmp/snmpd.users.conf.erb',
          description: 'Template to use to generate the configuration file'

property :sensitive, [true, false],
          default: true,
          description: 'Set sensitive true by default for user configuration file'

property :directive,
          equal_to: %i(createuser),
          default: :createuser,
          description: 'Do not change me'

property :user, String,
          description: 'SNMPv3 username',
          name_property: true

property :authentication, [Symbol, String],
          equal_to: %i(md5 sha),
          description: 'SNMPv3 authentication type',
          coerce: proc { |p| p.is_a?(Symbol) ? p : p.to_sym }

property :privacy, [Symbol, String],
          equal_to: %i(des aes),
          description: 'SNMPv3 privacy type',
          coerce: proc { |p| p.is_a?(Symbol) ? p : p.to_sym }

property :authpassphrase, String,
          description: 'SNMPv3 authentication passphrase',
          coerce: proc { |p| "\"#{p}\"" }

property :privacypassphrase, String,
          description: 'SNMPv3 privacy passphrase',
          coerce: proc { |p| "\"#{p}\"" }

property :engineid, String,
          description: 'Override the SNMPv3 engine ID'

action :create do
  init_config_file_resource

  node.run_state['snmpd_config_files'] ||= []
  node.run_state['snmpd_config_files'].push(new_resource.config_file) unless node.run_state['snmpd_config_files'].include?(new_resource.config_file)

  config_file_resource.variables['users'] ||= []
  config_file_resource.variables['users'].push(resource_property_set)
end

# action :delete do
#   init_config_file_resource

#   unless nil_or_empty?(config_file_resource.variables['users'])
#     index = config_file_resource.variables['users'].index { |user| user['user'] == new_resource.user }
#     config_file_resource.variables['users'].delete_at(index) unless index.nil?
#   end
# end
