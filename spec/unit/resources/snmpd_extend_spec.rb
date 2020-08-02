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
  step_into :net_snmp_snmpd_extend
  platform 'centos'

  context 'Create net-snmp snmpd configuration file extend/pass' do
    recipe do
      net_snmp_snmpd_extend 'distro' do
        type :extend
        miboid '.1.3.6.1.4.1.2021.7890.1'
        program '/usr/bin/distro'
      end

      net_snmp_snmpd_extend 'pass_test' do
        type :pass
        miboid '.1.3.6.1.4.1.2022.7890.1'
        program '/usr/bin/pass_test'
      end
    end

    it 'Creates the global configuration file extend/pass correctly' do
      is_expected.to render_file('/etc/snmp/snmpd.conf')
        .with_content(%r{extend .1.3.6.1.4.1.2021.7890.1 distro /usr/bin/distro})
        .with_content(%r{pass .1.3.6.1.4.1.2022.7890.1  /usr/bin/pass_test})
    end
  end
end
