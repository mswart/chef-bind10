#
# Cookbook Name:: dovecot
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

default['bind10']['source_version'] = '1.1.0beta1'
default['bind10']['source_url'] = nil
default['bind10']['source_sha1'] = 'e907096beb5ffd1f364029aa674f553a361833c8'
