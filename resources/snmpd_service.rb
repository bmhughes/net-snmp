#
# Cookbook:: net_snmp
# Resource:: snmpd_service
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

use 'snmpd'

property :service_name, String,
          coerce: proc { |p| "#{p}.service" },
          default: lazy { snmpd_service_name },
          description: 'Override the default service name'

property :systemd_unit_content, [String, Hash],
          default: lazy { snmpd_default_systemd_unit_content(config_file) },
          description: 'Override the systemd unit file contents'

action_class do
  def do_service_action(service_action)
    with_run_context :root do
      edit_resource(:service, new_resource.service_name) do
        action :nothing
        delayed_action service_action
      end
    end
  end
end

action :create do
  with_run_context :root do
    edit_resource(:systemd_unit, new_resource.service_name) do |new_resource|
      content new_resource.systemd_unit_content
      triggers_reload true

      action :create
    end
  end
end

action :delete do
  do_service_action([:stop, :disable])
  with_run_context :root do
    edit_resource(:systemd_unit, new_resource.service_name).action(:delete)
  end
end

action :start do
  do_service_action(action)
end

action :stop do
  do_service_action(action)
end

action :restart do
  do_service_action(action)
end

action :reload do
  do_service_action(action)
end

action :enable do
  do_service_action(action)
end

action :disable do
  do_service_action(action)
end
