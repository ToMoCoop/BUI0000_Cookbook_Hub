# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'json'
chef_configuration = JSON.parse(Pathname(__FILE__).dirname.join('.', 'chef.json').read)

Vagrant.configure('2') do |config|
  config.berkshelf.enabled = true
  config.omnibus.chef_version = :latest
  config.vm.box = 'bento/ubuntu-16.04'
  config.vm.provider :virtualbox do |vb|
    vb.customize ['modifyvm', :id, '--memory', 2048]
  end
  config.vm.network :forwarded_port, :guest => 80, :host => 80, :auto_correct => true
  config.vm.network :forwarded_port, :guest => 443, :host => 443, :auto_correct => true
  config.vm.provision :chef_solo do |chef|
    chef.json = chef_configuration
  end
end



