chef-bind10 - Cookbook to install bind 10
=========================================

**This cookbook is currently under development and designing! Because the README is written before the feature is implemented, some points could be missing.**


Description
-----------

This cookbook installs [bind10](http://bind10.isc.org). Bind 10 is a complete rewrite of bind 9, introducing a modular architecture, support for database back ends and many more.

**Warning**: This cookbook currently does not configure bind 10. My intention is at this point to provide an easy way to install bind 10 and experiment with it. Afterwards it is planed to implement configuration support.


Requirements
------------

The cookbook requires:

* **ruby 1.8.7+**: Ruby 1.8.7 is currently full supported. But in a few month (also end of life of ruby), is will be dropped and **ruby 1.9** is needed.
* **chef 10.18+**: The cookbook is design to run under chef 10 and chef 11. Therefore I recommends chef 10.18+ because it is a preparing and migration release. Chef server and chef solo are supported. But some features may not available with chef solo.
* (**ubuntu**): The cookbook is tested on ubuntu 12.04. Other distributions like debian may work also. I appreciate feedback about status and errors on other distributions or versions.

but no other cookbooks.


Recipes
-------

The following recipes are supported:

* `default`: installs bind 10, determines the most suitable way (currently on compiling from source, installation from distribution package will be supported if packages are available).
* `source`: installs bind 10 from source. The recipe uses `checkinstall` to create a deb package which all installed files. To uninstall bind10 do `dpkg -r bind10`.


So ``recipe[bind10::default]`` is the recommended way.


Attributes
----------

### For recipe `source`

* `node['bind10']['source_version']` (`1.1.0-beta`): Which version should be installed, e.g. `1.0.0` or `1.1.0`.
* `node['bind10']['source_url']` (`nil`): Url of the source package which should be downloaded and installed. Use `nil` to generate the url from the `source_version` attribute.
* `node['bind10']['source_sha1']`: sha1 hash (as hexdigest) of the source archive. Use `nil` to skip source validation.
* `node['bind10']['configure_options']` (``): Additional options which are passed to `./configure` for bind10.


License and Author
------------------

Author:: Malte Swart (<chef@malteswart.de>)
Copyright:: 2013, Malte Swart

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
