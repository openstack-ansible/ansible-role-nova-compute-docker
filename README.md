nova compute docker ansible role
================================

The purpose of this role is to deploy nova-compute-docker onto Ubuntu. 

Role Variables
--------------

- openstack_mysql_host: 127.0.0.1
- openstack_mysql_port: 3306
- openstack_rabbitmq_host: 127.0.0.1
- openstack_rabbitmq_port: 5672
- openstack_compute_nova_docker_branch: harness-demo
- openstack_compute_nova_docker_package: novadocker
- openstack_log_verbose: true
- openstack_log_debug: false
- openstack_identity_region: RegionOne

Example Playbook
-------------------------

    - hosts: all
      sudo: True
      roles:
        - nova-compute-docker

License
-------

GPLv2

Author Information
------------------

http://stillwell.me
