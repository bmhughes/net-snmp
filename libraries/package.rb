#
# Cookbook:: net_snmp
# Library:: package
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

module NetSnmp
  module Cookbook
    module PackageHelpers
      def default_net_snmp_packages
        case node['platform_family']
        when 'rhel', 'fedora'
          %w(net-snmp net-snmp-agent-libs net-snmp-devel net-snmp-libs net-snmp-utils)
        when 'debian'
          %w(snmp snmpd snmptrapd)
        else
          raise "Platform family #{node['platform_family']} is not supported"
        end
      end
    end
  end
end
