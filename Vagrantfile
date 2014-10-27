# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'fileutils'

def local_cache(basebox_name)
  cache_dir = Vagrant::Environment.new.home_path.join('cache', basebox_name)
  FileUtils.mkpath cache_dir unless cache_dir.exist?
  cache_dir
end

VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  #config.vm.define "compute-001" do |machine|
  #  machine.vm.box = "ubuntu/trusty64"
  #  machine.vm.synced_folder local_cache(machine.vm.box), "/var/cache/apt"
  #  machine.vm.hostname = "compute-001"
  #  machine.vm.network :private_network, ip: "10.1.0.3",
  #                     :netmask => "255.255.0.0"
  #  machine.vm.provider :virtualbox do |v|
  #    v.customize ["modifyvm", :id, "--memory", 1280]
  #  end
  #end

  config.vm.define "compute-002" do |machine|
    machine.vm.box = "box-cutter/centos64"
    #machine.vm.synced_folder local_cache(machine.vm.box), "/var/cache/yum"
    machine.vm.hostname = "compute-002"
    machine.vm.network :private_network, ip: "10.1.0.4",
                       :netmask => "255.255.0.0"
    machine.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--memory", 1280]
    end
  end

  config.vm.define "controller" do |machine|
    machine.vm.box = "ubuntu/trusty64"
    #machine.vm.synced_folder local_cache(machine.vm.box), "/var/cache/apt/archives"
    machine.vm.hostname = "controller"
    machine.vm.network :private_network, ip: "10.1.0.2",
                       :netmask => "255.255.0.0"
    machine.vm.network :private_network, ip: "10.2.0.2",
                       :netmask => "255.255.0.0"
    machine.vm.provider :virtualbox do |v|
      v.customize ["modifyvm", :id, "--memory", 2048]
      v.customize ["modifyvm", :id, "--nicpromisc3", "allow-vms"]
    end

    machine.vm.provision "ansible" do |ansible|
      ansible.playbook = "provisioning/getreqs.yml"
      ansible.limit = 'all'
    end

    machine.vm.provision "ansible" do |ansible|
      ansible.playbook = "provisioning/prep.yml"
      ansible.extra_vars = {
        #nova_compute_dockerized_deployment: true,
        mariadb_bind_address: "0.0.0.0",
        openstack_network_node_ip: "{{ ansible_eth1.ipv4.address }}",
        openstack_network_external_device: "eth2",
        openstack_network_external_ip: "10.2.0.2",
        openstack_network_external_netmask: 16,
        openstack_network_external_name: "public",
        openstack_network_external_dns_servers: "8.8.8.8",
        openstack_network_external_allocation_pool_start: "10.2.0.100",
        openstack_network_external_allocation_pool_end: "10.2.0.200"
      }
      ansible.groups = {
        "compute" => ["compute-001", "compute-002"]
      }
      ansible.limit = 'all'
    end

    machine.vm.provision "ansible" do |ansible|
      ansible.playbook = "provisioning/deploy.yml"
      ansible.extra_vars = {
        #nova_compute_dockerized_deployment: true,
        openstack_compute_node_ip: "{{ ansible_eth1.ipv4.address }}"
      }
      ansible.groups = {
        "compute" => ["compute-001", "compute-002"]
      }
      ansible.limit = 'all'
    end

    machine.vm.provision "ansible" do |ansible|
      ansible.playbook = "provisioning/test.yml"
      ansible.extra_vars = {
        openstack_network_external_allocation_pool_start: "10.2.0.100"
      }
      ansible.limit = 'all'
    end

  end

end
