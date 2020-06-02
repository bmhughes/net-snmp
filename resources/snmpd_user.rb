#
# Cookbook:: net_snmp
# Resource:: snmpd_user
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

property :user, String,
          description: 'SNMPv3 username',
          name_property: true

property :authentication, String,
          equal_to: %w(md5 sha),
          description: 'SNMPv3 authentication type'

property :privacy, String,
          equal_to: %w(des aes),
          description: 'SNMPv3 privacy type'

property :authpassphrase, String,
          description: 'SNMPv3 authentication passphrase'

property :privacypassphrase, String,
          description: 'SNMPv3 privacy passphrase'

property :access, String,
          equal_to: %w(rouser rwuser),
          description: 'Access type for this user'

property :security, String,
          equal_to: %w(noauth auth priv),
          description: 'Allow security levels for this user'

property :oid, String,
          description: 'Restrict user to this OID root'

property :view, String,
          description: 'Restrict user to this view'

property :view_context, String,
          description: 'Restrict user to this view context'

action :create do
  init_config_file_resource

  snmpv3_user = {
    'user' => new_resource.user,
    'authentication' => new_resource.authentication,
    'privacy' => new_resource.privacy,
    'authpassphrase' => new_resource.authpassphrase,
    'privacypassphrase' => new_resource.privacypassphrase,
    'access' => new_resource.access,
    'security' => new_resource.security,
    'oid' => new_resource.oid,
    'view' => new_resource.view,
    'view_context' => new_resource.view_context,
  }

  config_file_resource.variables['users'] ||= []
  config_file_resource.variables['users'].push(snmpv3_user)
end

action :delete do
  init_config_file_resource

  unless nil_or_empty?(config_file_resource.variables['users'])
    index = config_file_resource.variables['users'].index { |user| user['user'] == new_resource.user }
    config_file_resource.variables['users'].delete_at(index) unless index.nil?
  end
end
