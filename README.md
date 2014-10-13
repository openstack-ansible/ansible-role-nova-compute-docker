marklee77.nova-controller
=========================

[![Build Status](https://travis-ci.org/marklee77/ansible-role-nova-controller.svg?branch=master)](https://travis-ci.org/marklee77/ansible-role-nova-controller)

The purpose of this role is to deploy nova-controller onto Ubuntu. There is
also support for an experimental "dockerized" deployment. This dockerized
deployment copies the role to the target machine and uses the original
ansible-based functionality to build a docker image, and then uses recent
ansible features to manage the running service. The dockerized deployment can
theoretically deploy to any Linux platform with a running docker install and
the docker-py python client library installed.

Travis status above refers only to the non-dockerized deployment, as docker does 
not (easily) run on travis.

Role Variables
--------------

The variables below only affect the dockerized deployment:

- nova-controller_dockerized_deployment: false
- nova-controller_docker_username: default
- nova-controller_docker_imagename: nova
- nova-controller_docker_containername: nova

Example Playbook
-------------------------

    - hosts: all
      sudo: True
      roles:
        - marklee77.nova-controller

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

- metadata...
- separate nova-api from nova-controller?
- delegate_to in order to allow for installing on hosts different from nova-controller host...
- consider making mapping of nova-controller port to host interface optional
- eventually, we're going to need a better way to pass in variables...
