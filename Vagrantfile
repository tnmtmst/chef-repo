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
      git: {
        version: "2.4.0",
        url: "https://www.kernel.org/pub/software/scm/git/git-2.4.0.tar.gz",
        checksum: "d58c766a80d86a5e1846c04c74618e98bfec158734fa1a8904c64740b72b511a"
      }
    }
    chef.run_list = %w[
      recipe[git::source]
      recipe[ruby-env]
      recipe[nodejs]
    ]
  end
end
