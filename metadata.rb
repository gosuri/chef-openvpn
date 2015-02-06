name             'openvpn2'
maintainer       'Greg Osuri'
maintainer_email 'gosuri@gmail.com'
license          'all_rights'
description      'Installs and configures OpenVPN server'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

supports 'amazon'
supports 'centos', '>= 6.0'
supports 'debian', '>= 7.0'
supports 'fedora', '>= 19.0'
supports 'redhat', '>= 6.0'
supports 'ubuntu', '>= 12.04'

depends 'chef-sugar', '~> 2.5.0'
depends 'apt'
depends 'yum-epel'
depends 'runit'
