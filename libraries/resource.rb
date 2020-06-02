#
# Cookbook:: net_snmp
# Library:: resource
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
    module ResourceHelpers
      def init_config_file_resource
        create_config_file_resource unless config_file_resource_exist?
      end

      def config_file_resource
        find_resource!(:template, new_resource.config_file)
      end

      private

      def config_file_resource_exist?
        begin
          r = find_resource!(:template, new_resource.config_file)
        rescue Chef::Exceptions::ResourceNotFound
          return false
        end

        return true unless r.nil?

        false
      end

      def create_config_file_resource
        with_run_context :root do
          edit_resource(:template, new_resource.config_file) do
            source new_resource.template
            cookbook new_resource.cookbook

            owner new_resource.owner
            group new_resource.group
            mode new_resource.mode
            sensitive new_resource.sensitive

            helpers(NetSnmp::Cookbook::GeneralHelpers)
            helpers(NetSnmp::Cookbook::TemplateHelpers)

            action :nothing
            delayed_action :create
          end
        end
      end
    end
  end
end
