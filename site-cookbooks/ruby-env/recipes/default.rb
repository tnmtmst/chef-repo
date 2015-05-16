#
# Cookbook Name:: ruby-env
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
%w{openssl-devel sqlite-devel gcc-c++ glibc-headers readline libyaml-devel readline-devel zlib zlib-devel}.each do |pkg|
  package pkg do
    action :install
  end
end

# rbenv
git "/usr/local/rbenv" do
  repository node["ruby-env"]["rbenv_url"]
  action :sync
  user  node['ruby-env']['user']
  group node['ruby-env']['group']
end

template "/etc/profile.d/rbenv.sh" do
  source "rbenv.sh.erb"
  mode   0644
  owner  node['ruby-env']['user']
  group  node['ruby-env']['group']
end

directory "/usr/local/rbenv/plugins" do
  owner node['ruby-env']['user']
  group node['ruby-env']['group']
  mode 0755
  action :create
end

# ruby-build
git "/usr/local/rbenv/plugins/ruby-build" do
  repository node["ruby-env"]["ruby-build_url"]
  action :sync
  user  node['ruby-env']['user']
  group node['ruby-env']['group']
end

# rbenv-default-gems
git "/usr/local/rbenv/plugins/rbenv-default-gems" do
  repository node["ruby-env"]["rbenv-default-gems_url"]
  action :sync
  user  node['ruby-env']['user']
  group node['ruby-env']['group']
end

template "default-gems" do
  source "default-gems.erb"
  path   "/usr/local/rbenv/default-gems"
  mode   0644
  owner  node['ruby-env']['user']
  group  node['ruby-env']['group']
end

# rbenv-gem-rehash
git "/usr/local/rbenv/plugins/rbenv-gem-rehash" do
  repository node["ruby-env"]["rbenv-gem-rehash_url"]
  action :sync
  user  node['ruby-env']['user']
  group node['ruby-env']['group']
end

# rbenv-update
git "/usr/local/rbenv/plugins/rbenv-update" do
  repository node["ruby-env"]["rbenv-update_url"]
  action :sync
  user  node['ruby-env']['user']
  group node['ruby-env']['group']
end

# Install Ruby
execute "rbenv install #{node['ruby-env']['version']}" do
  command "/usr/local/rbenv/bin/rbenv install #{node['ruby-env']['version']}"
  user  node['ruby-env']['user']
  environment 'RBENV_ROOT' => "/usr/local/rbenv"
  not_if { File.exists?("/usr/local/rbenv/versions/#{node['ruby-env']['version']}") }
end

# Set global Ruby version
execute "rbenv global #{node['ruby-env']['version']}" do
  command "/usr/local/rbenv/bin/rbenv global #{node['ruby-env']['version']}"
  user  node['ruby-env']['user']
  environment 'RBENV_ROOT' => "/usr/local/rbenv"
end
