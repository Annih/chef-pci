# Cookbook pci
[![Cookbook Version][cookbook_version]][supermarket_url]
[![License][license]][license]
[![Linux Build Status][linux_build]][linux_build]
[![Windows Build Status][windows_build]][windows_build]

Expose PCI information via automatic attributes even during compilation time of the first Chef run.

Due to the fact the Ohai plugins system requires a setup phase, this cookbooks does not use it.

## Requirements

This cookbook supports and requires Chef 12.7+.

### Platforms
* CentOS 6 & 7
* RedHat 6 & 7
* Windows Server 2012R2 & 2016

## Usage

This cookbooks exposes PCI information as automatic attributes, so you just need to load it.
To get access to the PCI attributes:
* from another cookbook -> add a dependency to `pci` in your cookbook's metadata.
* without cookbooks -> add the `pci::default` recipe to your node run-list.

## Attributes

Below attributes are available in `pci` root namespace.

Attribute     | Description 
--------------|--------------------------------------------------
`devices `    | A Hash of all available PCI devices on the node.
`pnp_mapping `| A mapping between PNPIDs an PCI slots on Windows.

## Recipes

This cookbook own a single `pci::default` recipe which does nothing.

### pci::default

This recipe does nothing, its only purpose is to load `pci` attributes by adding the cookbook via the run-list.

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

## License and Authors

* Authors [Baptiste Courtois][annih] (<b.courtois@criteo.com>)

```text
Copyright 2017 Baptiste Courtois

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
[annih]:            https://github.com/Annih
[repository]:       https://github.com/Annih/chef-pci
[linux_build]:      https://img.shields.io/travis/Annih/chef-pci/master.svg?label=linux
[windows_build]:    https://img.shields.io/appveyor/ci/Annih/chef-pci/master.svg?label=windows
[cookbook_version]: https://img.shields.io/cookbook/v/pci.svg
[license]:          https://img.shields.io/github/license/Annih/chef-pci.svg
[supermarket_url]:  https://supermarket.chef.io/cookbooks/pci
