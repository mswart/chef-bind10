#
# Cookbook Name:: bind10
# Attributes:: default
#
# Author:: Malte Swart (<chef@malteswart.de>)
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

default['bind10']['source']['version'] = '1.1.0beta1'
default['bind10']['source']['checksum'] = 'c1dd41df6beca221b2d8ca262c3b715c864d08904ca828ef1a9ed81f519489fe'
default['bind10']['source']['url'] = nil

default['bind10']['source']['configure_options'] = ''

default['bind10']['setproctitle']['version'] = '1.1.7'
default['bind10']['setproctitle']['checksum'] = 'c7fca7ca317e309f4d77649ed94ef296e30f8444a9fa75bfb6483b5e70efa882'
default['bind10']['setproctitle']['url'] = nil
