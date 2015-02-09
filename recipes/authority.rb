package 'unzip'

remote_file "#{Chef::Config[:file_cache_path]}/authority.zip" do
  source(node['openvpn2']['authority']['url'])
end

execute 'extract-authority' do
  command "unzip -o #{Chef::Config[:file_cache_path]}/authority.zip -d /usr/bin"
end

execute 'init-authority' do
  command "authority init #{node['openvpn2']['key_dir']}"
end

template "#{node['openvpn2']['key_dir']}/.authority/config" do
  source "authority_config.erb"
  variables(:config => node['openvpn2']['authority'])
end
