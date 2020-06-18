#
# Cookbook:: net_snmp_test
# Recipe:: access
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

net_snmp_snmpd_access_user 'testuser' do
  authentication :sha
  privacy :aes
  authpassphrase 'testpass123'
  privacypassphrase 'testpass123'
end

net_snmp_snmpd_access_basic 'testuser' do
  secmodel :usm
  directive :rouser
  security :priv
end

net_snmp_snmpd_access_vacm 'notConfigUser' do
  directive :com2sec
  source 'default'
  community 'public'

  action :create
end

net_snmp_snmpd_access_vacm 'notConfigGroup' do
  directive :group
  secmodel :v1
  security_name 'notConfigUser'

  action :create
end

net_snmp_snmpd_access_vacm 'notConfigGroup' do
  directive :group
  secmodel :v2c
  security_name 'notConfigUser'

  action :create
end

net_snmp_snmpd_access_vacm 'systemview' do
  directive :view
  view_type :included
  subtree '.1.3.6.1.2.1.1'

  action :create
end

net_snmp_snmpd_access_vacm 'systemview' do
  directive :view
  view_type :included
  subtree '.1.3.6.1.2.1.25.1.1'

  action :create
end

net_snmp_snmpd_access_vacm 'notConfigGroup-read-systemview' do
  directive :access
  group 'notConfigGroup'
  context '""'
  secmodel :any
  level 'noauth'
  prefix 'exact'
  read 'systemview'

  action :create
end
