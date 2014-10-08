FROM ansible/ubuntu14.04-ansible:stable
MAINTAINER Mark Stillwell <mark@stillwell.me>

COPY . /var/cache/docker/keystone
WORKDIR /var/cache/docker/keystone

RUN mkdir -p roles && ln -snf .. roles/marklee77.keystone
RUN ansible-playbook -i inventories/local.ini deploy.yml -e '{ \
      "keystone_dockerize_context" : "install" }'

VOLUME [ "/etc/keystone", "/var/lib/keystone", "/var/log/keystone" ]

USER keystone
CMD [ "/usr/bin/keystone-all" ]

EXPOSE 5000 35357
