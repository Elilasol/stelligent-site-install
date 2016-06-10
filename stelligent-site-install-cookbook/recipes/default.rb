#
# Cookbook Name:: stelligent-site-install
# Recipe:: default
#
# Copyright 2016, Paul Peterson
#
# All rights reserved - Do Not Redistribute
#

include_recipe "nginx"

user "#{node['user']}" do
  comment 'site-host user'
  home '/var/www'
end

directory "/var/www/#{node['stelligent']['site']}" do
  owner node['user']
  group node['user']
  mode '0755'
  action :create
  recursive true
end

nginx_site "#{node['stelligent']['site']}" do
  enable true
  template "#{node['stelligent']['site']}.erb"
end
