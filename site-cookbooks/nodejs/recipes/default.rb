#
# Cookbook Name:: nodejs
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
remote_file "/tmp/#{node['nodejs']['filename']}" do
  source "#{node['nodejs']['remote_url']}"
end

bash "install nodejs" do
  user "root"
  cwd  "/tmp"
  code <<-EOC
    tar xvzf #{node['nodejs']['filename']}
    cd #{node['nodejs']['dirname']}
    ./configure
    make
    make install
  EOC
end