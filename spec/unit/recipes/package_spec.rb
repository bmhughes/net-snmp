#
# Cookbook:: net_snmp
# Spec:: package
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

require 'spec_helper'

describe 'net_snmp::package' do
  platform 'centos'
  step_into :net_snmp_package

  context 'Install the net-snmp packages' do
    describe 'Installs net-snmp package' do
      it { is_expected.to install_package('net-snmp') }
    end

    describe 'Installs net-snmp-utils package' do
      it { is_expected.to install_package('net-snmp-utils') }
    end
  end
end
