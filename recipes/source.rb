#
# Cookbook Name:: bind10
# Recipe:: source
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

# install required packages / dev tools
packages = %w(autoconf libtool pkg-config libboost-all-dev libbotan1.10-dev liblog4cplus-dev libsqlite3-dev)

unless node.recipe? 'bind10::setproctitle'
  packages += %w(build-essential python3-dev checkinstall)
end

packages.each do |pkg|
  package pkg
end

# download source
version = node['bind10']['source']['version']
source_url = node['bind10']['source']['url'] || "http://ftp.isc.org/isc/bind10/#{version}/bind10-#{version}.tar.gz"

source_file  = "#{Chef::Config['file_cache_path'] || '/tmp'}/bind10-#{version}.tar.gz"
remote_file source_url do
  source source_url
  checksum node['bind10']['source']['checksum']
  path source_file
  backup false
end

# setup user
group 'bind' do
  system true
end

user 'bind' do
  gid 'bind'
  system true
  comment 'Bind Domain Name Server'
  home '/var/bind10'
  supports :manage_home => true
end

archive_file = "/var/cache/apt/archives/bind10_#{version}-1_#{node['kernel']['machine'].sub('x86_64', 'amd64').sub('i686', 'i386')}.deb"

# compile
bash 'build bind10' do
  cwd ::File.dirname(source_file)
  code <<-EOH
    set -e
    tar zxf #{::File.basename(source_file)}
    cd bind10-#{version}
    ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var #{node['bind10']['source']['configure_options']}
    make -j3
    mkdir -p etc/init
    cat > /etc/init/bind10.conf <<EOF
# bind10 - bind10 job file
description "bind10 Domain Name Server"

start on runlevel [2345]
stop on runlevel [!2345]

exec /usr/sbin/bind10 --user=bind
EOF
    echo /etc/init/bind10.conf > files.txt
    checkinstall --pkgname bind10 --pkgversion #{version} --pakdir=/var/cache/apt/archives --maintainer chef@#{node['fqdn']} --include files.txt --nodoc --default --install=no make install
  EOH
  creates archive_file
  notifies :run, 'execute[install bind10]'
end

# install
execute 'install bind10' do
  command "dpkg --install --skip-same-version '#{archive_file}'"
  action :nothing
  notifies :restart, 'service[bind10]'
end

service 'bind10' do
  provider Chef::Provider::Service::Upstart
  supports :status => true, :restart => true, :reload => true
  action :nothing
end
