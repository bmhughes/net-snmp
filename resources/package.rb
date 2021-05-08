#
# Cookbook:: net_snmp
# Resource:: package
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

unified_mode true

include NetSnmp::Cookbook::PackageHelpers

property :packages, [String, Array],
          default: lazy { default_net_snmp_packages },
          description: 'A list of packages to install'

action_class do
  def do_action(package_action)
    if platform?('debian')
      apt_repository 'non-free' do
        uri 'http://deb.debian.org/debian'
        components ['non-free']
        action :add
      end
    end

    new_resource.packages.each do |pkg|
      package pkg do
        action package_action
      end
    end
  end
end

action :install do
  do_action(action)
end

action :upgrade do
  do_action(action)
end

action :remove do
  do_action(action)
end
