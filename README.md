marklee77.glance
=================

[![Build Status](https://travis-ci.org/marklee77/ansible-role-glance.svg?branch=master)](https://travis-ci.org/marklee77/ansible-role-glance)

The purpose of this role is to deploy glance onto Ubuntu. There is also an
support for an experimental "dockerized" deployment. This dockerized deployment
copies the role to the target machine and uses the original ansible-based
functionality to build a docker image, and then uses recent ansible features to
manage the running service. The dockerized deployment can theoretically deploy
to any Linux platform with a running docker install and the docker-py python
client library installed.

Travis status above refers only to the non-dockerized deployment, as docker does 
not (easily) run on travis.

Role Variables
--------------

- glance_repository_mirror: http://mirrors.coreix.net/glance by default.
- glance_version: 10.0
- glance_mysql_root_password: random value
- glance_enable_remote: false
- glance_set_root_password: true

The variables below only affect the dockerized deployment:

- glance_dockerized_deployment: false
- glance_docker_username: default
- glance_docker_imagename: glance
- glance_docker_containername: glance
- glance_port: 3306

Example Playbook
-------------------------

    - hosts: all
      sudo: True
      roles:
        - marklee77.glance

License
-------

GPLv2

Author Information
------------------

http://stillwell.me

Known Issues
------------

- the dockerized deployment still requires sudo access, even though a member of 
  the docker group should be able to build and deploy containers without sudo.

Todo
----

- delegate_to in order to allow for installing on hosts different from glance host...
- consider making mapping of glance port to host interface optional
- eventually, we're going to need a better way to pass in variables...
