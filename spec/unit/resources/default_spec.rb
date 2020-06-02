#
# Cookbook:: net_snmp
# Spec:: default
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

require 'spec_helper'

# For a complete list of available platforms and versions see:
# https://github.com/customink/fauxhai/blob/master/PLATFORMS.md

describe 'net_snmp::default' do
  platforms = {
    'CentOS' => '8',
    'Fedora' => '31',
  }

  platforms.each do |platform, version|
    context "With net_snmp::default, on #{platform} #{version}" do
      let(:chef_run) { ChefSpec::SoloRunner.new(platform: platform.dup.downcase!, version: version).converge(described_recipe) }

      it 'converges successfully' do
        expect { chef_run }.to_not raise_error
      end
    end
  end
end
