#
# Cookbook:: net_snmp
# Library:: general
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

module NetSnmp
  module Cookbook
    module GeneralHelpers
      def snmp_config_dir
        '/etc/snmp'
      end

      def snmp_config_file
        'snmp.conf'
      end

      def snmpd_config_file
        'snmpd.conf'
      end

      def snmpd_config_user_file
        'snmpd.users.conf'
      end

      def default_net_snmp_user
        'root'
      end

      def default_net_snmp_group
        'root'
      end

      def snmpd_service_name
        'snmpd'
      end

      def snmpd_default_config(section)
        case section
        when :agent
          {
            'agentaddress' => %w(udp:127.0.0.1:161 udp6:[::1]:161),
            'agentuser' => default_net_snmp_user,
            'agentgroup' => default_net_snmp_group,
          }
        when :agentx
          {
            'master' => 'agentx',
            'agentXPerms' => '0770 0770 root root',
            'agentXTimeout' => 1,
            'agentXRetries' => 5,
          }
        when :logging
          {
            'dontLogTCPWrappersConnects' => 'yes',
          }
        when :system
          {
            'sysName' => node['hostname'],
            'sysLocation' => 'Unknown (edit /etc/snmp/snmpd.conf)',
            'sysContact' => "root@#{node['hostname']}",
          }
        else
          raise "Unknown configuration section #{section}"
        end
      end

      def snmpd_default_systemd_unit_content(config_file)
        case node['platform']
        when 'amazon', 'centos', 'fedora', 'redhat'
          {
            'Unit' => {
              'Description' => 'Simple Network Management Protocol (SNMP) Daemon.',
              'After' => [
                'syslog.target',
                'network.target',
              ],
            },
            'Service' => {
              'Type' => 'notify',
              'Environment' => 'OPTIONS="-LS0-6d"',
              'EnvironmentFile' => '-/etc/sysconfig/snmpd',
              'ExecStart' => "/usr/sbin/snmpd $OPTIONS -f -c #{snmp_config_dir}/#{snmpd_config_file},#{snmp_config_dir}/#{snmpd_config_user_file}",
              'ExecReload' => '/bin/kill -HUP $MAINPID',
            },
            'Install' => {
              'WantedBy' => 'multi-user.target',
            },
          }
        when 'debian'
          {
            'Unit' => {
              'Description' => 'Simple Network Management Protocol (SNMP) Daemon.',
              'After' => 'network.target',
              'ConditionPathExists' => '/etc/snmp/snmpd.conf',
            },
            'Service' => {
              'Environment' => [
                '"MIBSDIR=/usr/share/snmp/mibs:/usr/share/snmp/mibs/iana:/usr/share/snmp/mibs/ietf:/usr/share/mibs/site:/usr/share/snmp/mibs:/usr/share/mibs/iana:/usr/share/mibs/ietf:/usr/share/mibs/netsnmp"',
                '"MIBS="',
              ],
              'Type' => 'simple',
              'ExecStartPre' => '/bin/mkdir -p /var/run/agentx',
              'ExecStart' => "/usr/sbin/snmpd -Lsd -Lf /dev/null -u Debian-snmp -g Debian-snmp -I -smux,mteTrigger,mteTriggerConf -f -p /run/snmpd.pid -c #{snmp_config_dir}/#{snmpd_config_file},#{snmp_config_dir}/#{snmpd_config_user_file}",
              'ExecReload' => '/bin/kill -HUP $MAINPID',
            },
            'Install' => {
              'WantedBy' => 'multi-user.target',
            },
          }
        when 'ubuntu'
          {
            'Unit' => {
              'Description' => 'Simple Network Management Protocol (SNMP) Daemon.',
              'After' => 'network.target',
              'ConditionPathExists' => '/etc/snmp/snmpd.conf',
            },
            'Service' => {
              'Type' => 'simple',
              'ExecStartPre' => '/bin/mkdir -p /var/run/agentx',
              'ExecStart' => "/usr/sbin/snmpd -LOw -u Debian-snmp -g Debian-snmp -I -smux,mteTrigger,mteTriggerConf -f -p /run/snmpd.pid -c #{snmp_config_dir}/#{snmpd_config_file},#{snmp_config_dir}/#{snmpd_config_user_file}",
              'ExecReload' => '/bin/kill -HUP $MAINPID',
            },
            'Install' => {
              'WantedBy' => 'multi-user.target',
            },
          }
        end
      end

      def nil_or_empty?(property)
        return true if property.nil? || safe_empty?(property)

        false
      end

      def safe_empty?(property)
        return true if property.respond_to?(:empty?) && property.empty?

        false
      end
    end
  end
end
