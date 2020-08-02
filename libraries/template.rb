#
# Cookbook:: net_snmp
# Library:: template
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

include NetSnmp::Cookbook::ConfigHelpers

module NetSnmp
  module Cookbook
    module TemplateHelpers
      def snmpd_access_user_builder(user)
        user_string = template_format_string('createUser', 15)
        user_string.concat(template_format_string("#{user['user']} ", 15))
        user_string.concat(template_format_string("#{user['authentication'].upcase} ", 15)) if user['authentication']
        user_string.concat(template_format_string("#{user['authpassphrase']} ", 31)) if user['authpassphrase']
        user_string.concat(template_format_string("#{user['privacy'].upcase} ", 15)) if user['privacy']
        user_string.concat(template_format_string("#{user['privacypassphrase']} ", 31)) if user['privacypassphrase']

        user_string.strip
      end

      def snmpd_access_basic_user_builder(configuration)
        user_string = "#{configuration['access']} "
        user_string.concat("#{configuration['user']} ")
        user_string.concat("#{configuration['security']} ") if configuration['security']
        user_string.concat("#{configuration['oid']} ") if configuration['oid']
        user_string.concat("-V #{configuration['view']} ") if configuration['view']
        user_string.concat("-V #{configuration['view_context']} ") if configuration['view'] && configuration['view_context']

        user_string.strip
      end

      def snmpd_access_title_line(directive)
        title_line = '##'.ljust(16)

        snmpd_access_properties(directive, :all).each do |property|
          min_length = %w(oid authpassphrase privacypassphrase).include?(property) ? 31 : 15
          title_line.concat(template_format_string(property, min_length))
        end

        title_line
      end

      def snmpd_access_builder(directive, configuration)
        config_string = ''
        config_string.concat(directive.to_s.ljust(16))

        snmpd_access_properties(directive, :all).each do |property|
          min_length = %w(oid authpassphrase privacypassphrase).include?(property) ? 31 : 15
          property_value = configuration.fetch(property, ' ').dup

          if %i(rouser rwuser rocommunity rwcommunity rocommunity6 rwcommunity6 com2sec com2sec6 com2secunix).include?(directive) && !property_value.eql?(' ')
            case property
            when 'secmodel', 'model'
              property_value.prepend('-s ')
            when 'context'
              property_value.prepend('-Cn ')
            when 'view'
              property_value.prepend('-V ')
            end
          end

          config_string.concat(template_format_string(property_value, min_length))
        end

        config_string.strip
      end

      private

      def template_format_string(string, min_length)
        return "#{' '.ljust(min_length)} " if nil_or_empty?(string)

        "#{string.ljust(min_length)} "
      end
    end
  end
end
