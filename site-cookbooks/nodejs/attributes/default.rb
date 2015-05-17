default['nodejs']['version'] = "v0.12.3"
default['nodejs']['dirname'] = "node-#{default['nodejs']['version']}"
default['nodejs']['filename'] = "#{default['nodejs']['dirname']}.tar.gz"
default['nodejs']['remote_url'] = "http://nodejs.org/dist/#{default['nodejs']['version']}/#{default['nodejs']['filename']}"