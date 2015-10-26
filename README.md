nova compute docker ansible role
================================

[![DOI](https://zenodo.org/badge/7696/harnesscloud/ansible-role-nova-compute-docker.svg)](https://zenodo.org/badge/latestdoi/7696/harnesscloud/ansible-role-nova-compute-docker)

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
        - docker
        - nova-compute-docker

License
-------

GPLv2

Author Information
------------------

http://stillwell.me
