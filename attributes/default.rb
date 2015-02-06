default['openvpn2'].tap do |openvpn|
  openvpn['init_type'] = value_for_platform(
    %w(amazon debian oracle) => {
      'default' => 'sysv'
    },
    %w(redhat centos) => {
      %w(6.0 6.1 6.2 6.3 6.4 6.5 6.6) => 'sysv',
      'default' => 'systemd'
    },
    %w(fedora) => {
      'default' => 'systemd'
    },
    %w(ubuntu) => {
      'default' => 'upstart'
    },
    'default' => 'upstart'
  )

  # user and group to run openvpn 
  openvpn['user']   = 'openvpn'
  openvpn['group']  = 'openvpn'
end
