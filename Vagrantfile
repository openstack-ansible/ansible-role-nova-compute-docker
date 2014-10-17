# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'fileutils'

def local_cache(basebox_name)
  cache_dir = Vagrant::Environment.new.home_path.join('cache', 'apt', basebox_name)
  partial_dir = cache_dir.join('partial')
  FileUtils.mkpath partial_dir unless partial_dir.exist?
  cache_dir
end

VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "ubuntu/trusty64"
  config.vm.synced_folder local_cache(config.vm.box), "/var/cache/apt/archives/"

  config.vm.define "default" do |machine|
    machine.vm.network :private_network, ip: "10.13.0.2",
                       :netmask => "255.255.0.0"
    machine.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--memory", 2048]
      v.customize ["modifyvm", :id, "--nicpromisc2", "allow-vms"]
    end
  end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "getreqs.yml"
  end

  #config.vm.provision "ansible" do |ansible|
  #  ansible.playbook = "prep.yml"
  #  ansible.extra_vars = {
  #    openstack_identity_endpoint_host: "10.13.0.2",
  #    openstack_image_endpoint_host: "10.13.0.2",
  #    openstack_compute_endpoint_host: "10.13.0.2",
  #    openstack_vncserver_bind_address: "10.13.0.2",
  #    openstack_network_endpoint_host: "10.13.0.2",
  #    openstack_network_external_name: "public",
  #    openstack_network_external_device: "eth1",
  #    openstack_network_external_ip: "10.13.0.2",
  #    openstack_network_external_netmask: "16",
  #    openstack_network_external_network: "10.13.0.2/16",
  #    openstack_network_external_allocation_pool_start: "10.13.0.100",
  #    openstack_network_external_allocation_pool_end: "10.13.0.200",
  #    openstack_network_external_dns_servers: "8.8.8.8"
  #  }
  #end

  #config.vm.provision "ansible" do |ansible|
  #  ansible.playbook = "deploy.yml"
  #  ansible.extra_vars = {
  #    openstack_compute_node_ip: "10.13.0.2",
  #    openstack_identity_endpoint_host: "10.13.0.2",
  #    openstack_image_endpoint_host: "10.13.0.2",
  #    openstack_compute_endpoint_host: "10.13.0.2",
  #    openstack_network_endpoint_host: "10.13.0.2"
  #  }
  #end

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "test.yml"
  end

end
