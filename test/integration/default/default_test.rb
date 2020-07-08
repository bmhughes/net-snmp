#
# Cookbook:: net_snmp
# Spec:: default
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

describe service('snmpd') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe directory('/etc/snmp') do
  it { should exist }
end

describe file('/etc/snmp/snmp.conf') do
  it { should exist }
  its('type') { should cmp 'file' }
  it { should be_file }
  it { should_not be_directory }
end

describe file('/etc/snmp/snmpd.conf') do
  it { should exist }
  its('type') { should cmp 'file' }
  it { should be_file }
  it { should_not be_directory }
end

describe port(161) do
  it { should be_listening }
  its('processes') { should include 'snmpd' }
end
