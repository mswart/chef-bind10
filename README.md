chef-bind10 - Cookbook to install BIND 10
=========================================

Description
-----------

This cookbook installs [bind10](http://bind10.isc.org). Bind 10 is a complete rewrite of BIND 9, introducing a modular architecture, support for database back ends and many more.

**Warning**: This cookbook currently does not configure BIND 10. My intention is at this point to provide an easy way to install BIND 10 and experiment with it. It is planed to implement configuration support afterwards.


Requirements
------------

The cookbook requires:

* **Ruby 1.8.7+**: Ruby 1.8.7 is currently full supported. But in a few month (also end of life of Ruby), is will be dropped and **Ruby 1.9** is needed.
* **Chef 10.18+**: The cookbook is design to run under Chef 10 and Chef 11. Therefore I recommends Chef 10.18+ because it is a preparing and migration release. Chef server and Chef solo are supported. But some features may not available with Chef solo.
* **Ubuntu**: The cookbook is tested on Ubuntu 12.04. Other distributions like Debian require probable some changes. I appreciate feedback about status and errors on other distributions or versions.

but no other cookbooks.


Recipes
-------

The following recipes are supported:

* `default`: installs BIND 10, determines the most suitable way (currently on compiling from source, installation from distribution package will be supported if packages are available).
* `source`: installs BIND 10 from source. The recipe uses `checkinstall` to create a deb package with all installed files. To uninstall BIND 10 do `dpkg -r bind10`.
* `setproctitle`: installs setproctitle - optional dependency to set nicer process titles.

So ``recipe[bind10::default]`` is the recommended way.


Attributes
----------

### For recipe `source`

* `node['bind10']['source']['version']` (`1.1.0-beta`): Which version should be installed, e.g. `1.0.0` or `1.1.0`.
* `node['bind10']['source']['url']` (`nil`): Url of the source package which should be downloaded and installed. Use `nil` to generate the url from the `source_version` attribute.
* `node['bind10']['source']['checksum']`: sha256 hash (as hexdigest) of the source archive. Use `nil` to skip source validation.
* `node['bind10']['source']['configure_options']` (`''`): Additional options which are passed to `./configure` for BIND 10.

### For recipe `setproctitle`

Options `node['bind10']['setproctitle']['version']`, `node['bind10']['setproctitle']['url']` and `node['bind10']['setproctitle']['checksum']` like for `source` recipe. Per default version 1.1.7 is installed.


Contributing
------------

The cookbook is developed on [github](https://github.com). To report bugs [create an issue](https://github.com/mswart/chef-bind10/issues) or open a pull request if you now what needs to be changed.

Feel free to contact me (<chef@malteswart.de> or mswart on freenode) if you have detailed questions about the cookbook. I am interested in your opinion and use cases.


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
