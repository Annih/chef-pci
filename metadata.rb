name             'pci'
maintainer       'Annih'
maintainer_email 'b.courtois@criteo.com'
license          'Apache-2.0'
description      'Expose PCI information as automatic attributes'
long_description ::IO.read(::File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

supports         'centos', '>= 6.0'
supports         'redhat', '>= 6.0'
supports         'windows', '>= 6.3'

chef_version     '>= 12.7'                             if respond_to? :chef_version
source_url       'https://github.com/annih/pci'        if respond_to? :source_url
issues_url       'https://github.com/annih/pci/issues' if respond_to? :issues_url
