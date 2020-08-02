#
# Cookbook:: net_snmp
# Library:: config
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
    module ConfigHelpers
      def snmpd_properties(set)
        raise unless %i(all required).include?(set)

        case new_resource.declared_type
        when :net_snmp_snmpd_access_basic, :net_snmp_snmpd_access_vacm, :net_snmp_snmpd_access_user
          snmpd_access_properties(new_resource.directive, set)
        when :net_snmp_snmpd_extend
          snmpd_extend_properties(new_resource.type, set)
        when :net_snmp_snmpd_override
          snmpd_override_properties(set)
        when :net_snmp_snmpd_proxy
          snmpd_proxy_properties(set)
        else
          raise ArgumentError, "snmpd_properties: Unknown resource type :#{new_resource.declared_type}"
        end
      end

      private

      def snmpd_access_properties(directive, set)
        p = case directive
            when :rouser, :rwuser
              {
                join_method: 'zip',
                required: [ nil, 'name', nil, nil, nil ],
                optional: %w(secmodel security oid view view_context),
              }
            when :rocommunity, :rwcommunity, :rocommunity6, :rwcommunity6
              {
                join_method: 'push',
                required: %w(name),
                optional: %w(source oid view view_context),
              }
            when :com2sec, :com2sec6
              {
                join_method: 'zip',
                required: [nil, 'name', 'source', 'community'],
                optional: ['context', nil, nil, nil],
              }
            when :com2secunix
              {
                join_method: 'zip',
                required: [nil, 'name', 'sockpath', 'community'],
                optional: ['context', nil, nil, nil],
              }
            when :group
              {
                join_method: 'push',
                required: %w(name secmodel secname),
                optional: [],
              }
            when :view
              {
                join_method: 'zip',
                required: %w(name view_type subtree),
                optional: [nil, nil, nil, 'mask'],
              }
            when :access
              {
                join_method: 'push',
                required: %w(group context secmodel level prefix read write notify),
                optional: [],
              }
            when :authcommunity
              {
                join_method: 'push',
                required: %w(types community),
                optional: %w(source oid view context),
              }
            when :authuser
              {
                join_method: 'zip',
                required: ['types', 'user', nil, nil, nil],
                optional: %w(model level oid view context),
              }
            when :authgroup
              {
                join_method: 'zip',
                required: ['types', 'group', nil, nil, nil],
                optional: %w(model level oid view context),
              }
            when :authaccess
              {
                join_method: 'zip',
                required: ['types', 'group', 'view', nil],
                optional: ['model', nil, 'level', 'context'],
              }
            when :setaccess
              {
                join_method: 'push',
                required: %w(group context model level prefix view types),
                optional: [],
              }
            when :createuser
              {
                join_method: 'push',
                required: %w(user authentication authpassphrase),
                optional: %w(privacy privacypassphrase),
              }
            else
              raise ArgumentError, "snmpd_access_properties: Unsupported configuration directive #{type}."
            end

        return p[:required].compact if set.eql?(:required)

        p[:required].send(p[:join_method], p[:optional]).flatten.compact
      end

      def snmpd_extend_properties(directive, set)
        p = case directive
            when :sh, :exec, :execfix, :extend, :extendfix
              {
                required: %w(type name program),
                optional: ['miboid', nil, 'arguments'],
              }
            when :pass, :pass_persist
              {
                required: %w(type miboid program),
                optional: ['priority', nil, nil],
              }
            else
              raise ArgumentError, "snmpd_extend_properties: Unsupported configuration directive #{type}."
            end

        return p[:required] if set.eql?(:required)

        p[:required].zip(p[:optional]).flatten.compact
      end

      def snmpd_override_properties(set)
        p = {
          required: %w(oid type value),
          optional: %(rw),
        }

        return p[:required] if set.eql?(:required)

        p[:required].push(p[:optional]).flatten.compact
      end

      def snmpd_proxy_properties(set)
        p = {
          required: %w(host oid),
          optional: %w(context snmp_command_arguments remote_oid),
        }

        return p[:required] if set.eql?(:required)

        p[:required].push(p[:optional]).flatten.compact
      end
    end
  end
end
