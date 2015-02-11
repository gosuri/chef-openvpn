default['openvpn2'].tap do |openvpn|
  # user and group to run openvpn 
  openvpn['user']     = 'openvpn'
  openvpn['group']    = 'openvpn'

  # directory to store keys and certs
  openvpn['key_dir']  = '/var/authority'

  openvpn['subnet']   = "10.8.0.0"
  openvpn['netmask']  = "255.255.0.0"

  openvpn['type']     = nil
  openvpn['proto']    = 'udp'
  openvpn['port']     = '1194'
  openvpn['gateway']  = node[:ipaddress]

  openvpn['users_databag']  = "users"
  openvpn['databag_search_query']  = "*:*"

  # openvpn server config
  openvpn['config'].tap do |config|
    config['local']           = node['ipaddress']
    config['proto']           = node['openvpn2']['proto']
    config['port']            = node['openvpn2']['port']
    config['keepalive']       = '10 120'
    config['comp-lzo']        = ""
    config['log']             = '/var/log/openvpn.log'
    config['status']          = '/var/log/openvpn-status.log'
    config['routes']          = nil
    config['script-security'] = 2
    config['server']          = "#{node['openvpn2']['subnet']} #{node['openvpn2']['netmask']}"

    config['user']  = 'nobody'
    config['group'] = value_for_platform_family('rhel' => 'nobody', 'default' => 'nogroup')

    config['ca']    = "#{node['openvpn2']['key_dir']}/certs/ca.crt"
    config['cert']  = "#{node['openvpn2']['key_dir']}/certs/server.crt"
    config['key']   = "#{node['openvpn2']['key_dir']}/keys/server.key"
    config['dh']    = "#{node['openvpn2']['key_dir']}/dh.pem"
    config['dev']   =  node['openvpn2']['type'] == 'server-bridge' ? 'tap0' : 'tun0'
  end

  # key provisioner (authority) config
  openvpn['authority']['version'] = "0.1.0.dev"
  openvpn['authority']['url'] = "http://dl.bintray.com/ovrclk/pkgs/authority_#{node['openvpn2']['authority']['version']}_linux_amd64.zip"
  openvpn['authority']['defaults'].tap do |k|
    k['root_domain']  = "authority.root"
    k['email']        = "user@example.com"
    k['org_unit']     = "OpenVPN"
    k['city']         = "San Francisco"
    k['region']       = "California"
    k['country']      = "US"
    k['cert_expiry']  = "3650"
    k['digest']       = "sha256"
    k['crl_days']     = "365"
  end

  # init type attributes
  openvpn['init_type'] = value_for_platform(
    %w(amazon debian oracle) => { 'default' => 'sysv' },
    %w(redhat centos) => { %w(6.0 6.1 6.2 6.3 6.4 6.5 6.6) => 'sysv', 'default' => 'systemd' },
    %w(fedora) => { 'default' => 'systemd' },
    %w(ubuntu) => { 'default' => 'upstart' },
    'default' => 'upstart'
  )
end
