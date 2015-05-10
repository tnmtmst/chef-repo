# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.hostname = "guest"
  config.vm.box = "opscode-centos-6.6"
  config.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_centos-6.6_chef-provisionerless.box"

  config.vm.network "private_network", ip: "192.168.33.10"

  config.omnibus.chef_version = :latest

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["./cookbooks", "./site-cookbooks"]
    chef.json = {
      nginx: {
        env: ["php"]
      }
    }
    chef.run_list = %w[
      recipe[yum-epel]
      recipe[nginx]
      recipe[php-env]
      recipe[ruby-env]
    ]
  end
end
