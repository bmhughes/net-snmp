#
# Cookbook:: net_snmp
# Spec:: destination_spec
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

require 'spec_helper'

describe 'net_snmp_snmpd_config' do
  step_into :net_snmp_snmpd_proxy
  platform 'centos'

  context 'Create net-snmp snmpd configuration file override' do
    recipe do
      net_snmp_snmpd_proxy 'Test Proxy' do
        host '127.0.0.127'
        oid '.1.2.3'
      end
    end

    it 'Creates the global configuration file override correctly' do
      is_expected.to render_file('/etc/snmp/snmpd.conf')
        .with_content(/proxy  127.0.0.127 .1.2.3/)
    end
  end
end
