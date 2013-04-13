#
# Cookbook Name:: bind10
# Recipe:: setproctitle
#
# Copyright 2013, Malte Swart
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
#

%w(build-essential python3-dev checkinstall).each do |pkg|
  package pkg
end

version = node['bind10']['setproctitle']['version']
source_url = node['bind10']['setproctitle']['url'] || "https://pypi.python.org/packages/source/s/setproctitle/setproctitle-#{version}.tar.gz"

source_file  = "#{Chef::Config['file_cache_path'] || '/tmp'}/setproctitle-#{version}.tar.gz"
remote_file source_url do
  source source_url
  checksum node['bind10']['setproctitle']['checksum']
  path source_file
  backup false
end

archive_file = "/var/cache/apt/archives/setproctitle_#{version}-1_#{node['kernel']['machine'].sub('x86_64', 'amd64').sub('i686', 'i386')}.deb"

bash 'install setproctitle' do
  cwd ::File.dirname(source_file)
  code <<-EOH
    set -e
    tar zxf #{::File.basename(source_file)}
    cd setproctitle-#{version}
    python3 setup.py build
    checkinstall --pkgname python3-setproctitle --pkgversion #{version} --pakdir=/var/cache/apt/archives --maintainer chef@#{node['fqdn']} --nodoc --default python3 setup.py install
  EOH
  creates archive_file
end
