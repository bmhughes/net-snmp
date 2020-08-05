name 'net_snmp'
maintainer 'Ben Hughes'
maintainer_email 'bmhughes@bmhughes.co.uk'
license 'Apache-2.0'
description 'Installs/Configures net_snmp'
version '0.1.1'
chef_version '>= 16.0'

issues_url 'https://gitlab.bmhughes.co.uk/bmhughes-net-chef/wrappers/net_snmp/issues'
source_url 'https://gitlab.bmhughes.co.uk/bmhughes-net-chef/wrappers/net_snmp'

%w(centos fedora redhat debian ubuntu).each { |os| supports os }
