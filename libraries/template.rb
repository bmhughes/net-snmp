#
# Cookbook:: net_snmp
# Library:: template
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
    module TemplateHelpers
      def snmpv3_user_builder(user)
        user_string = 'createUser '
        user_string.concat("#{user['user']} ")
        user_string.concat("#{user['authentication']} ") if user['authentication']
        user_string.concat("#{user['authpassphrase']} ") if user['authpassphrase']
        user_string.concat("#{user['privacy']} ") if user['privacy']
        user_string.concat("#{user['privacypassphrase']} ") if user['privacypassphrase']

        user_string.strip
      end

      def snmp_user_access_builder(user)
        user_string = "#{user['access']} "
        user_string.concat("#{user['user']} ")
        user_string.concat("#{user['security']} ") if user['security']
        user_string.concat("#{user['oid']} ") if user['oid']
        user_string.concat("-V #{user['view']} ") if user['view']
        user_string.concat("-V #{user['view_context']} ") if user['view'] && user['view_context']

        user_string.strip
      end

      def snmp_community_access_builder(community)
        community_string = "#{community['access']} "
        community_string.concat("#{community['name']} ")
        community_string.concat("#{community['source']} ") if community['security']
        community_string.concat("#{community['oid']} ") if community['oid']
        community_string.concat("-V #{community['view']} ") if community['view']
        community_string.concat("-V #{community['view_context']} ") if community['view'] && community['view_context']

        community_string.strip
      end
    end
  end
end
