#
# Cookbook Name:: openvpn2
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe('chef-sugar::default')
include_recipe('openvpn2::package')

# create openvpn user and group
user(node['openvpn2']['user'])
group(node['openvpn2']['user']) do
  members(node['openvpn2']['user'])
end
