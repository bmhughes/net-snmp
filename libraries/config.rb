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
      def snmpd_access_properties_required(type)
        snmpd_access_properties(type)[:required].compact
      end

      def snmpd_access_properties_all(type)
        properties = snmpd_access_properties(type)
        properties[:required].send(properties[:join_method], properties[:optional]).flatten.compact
      end

      private

      def snmpd_access_properties(type)
        case type
        when :rouser, :rwuser
          {
            join_method: 'push',
            required: %w(secmodel name),
            optional: %w(security oid view view_context),
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
            required: %w(name sockpath community),
            optional: ['context', nil, nil],
          }
        when :group
          {
            join_method: 'push',
            required: %w(name secmodel security_name),
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
      end
    end
  end
end
