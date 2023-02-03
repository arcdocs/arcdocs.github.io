# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "hashicorp/bionic64"

  config.vm.hostname = "arcdocsSite"

  config.vm.provision :shell, path: "vagrant/bootstrap.sh"
end
