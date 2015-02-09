include_recipe('openvpn2::authority')
include_recipe('openvpn2::package')

# create openvpn user and group
user(node['openvpn2']['user'])
group(node['openvpn2']['user']) do
  members(node['openvpn2']['user'])
end

# generate server keys
execute 'create-server-keys' do
  cwd(node['openvpn2']['key_dir'])
  command 'authority generate server'
  not_if { ::File.exist?("#{node['openvpn2']['key_dir']}/certs/server.crt") }
end

openvpn2_config 'server' do
  #notifies :restart, 'service[openvpn]'
  #only_if { node['openvpn']['configure_default_server'] }
  action :create
end
