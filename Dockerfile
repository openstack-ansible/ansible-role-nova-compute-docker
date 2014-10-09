FROM ansible/ubuntu14.04-ansible:stable
MAINTAINER Mark Stillwell <mark@stillwell.me>

COPY . /var/cache/docker/glance
WORKDIR /var/cache/docker/glance

RUN mkdir -p roles && ln -snf .. roles/marklee77.glance
RUN ansible-playbook -i inventories/local.ini deploy.yml -e '{ \
      "glance_dockerize_context" : "install" }'

VOLUME [ "/etc/glance", "/var/lib/glance", "/var/log/glance" ]

CMD [ "sudo", "-u", "keystone", "/usr/bin/keystone-all" ]

EXPOSE 5000 35357
