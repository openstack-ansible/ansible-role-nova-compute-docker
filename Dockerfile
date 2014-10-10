FROM ansible/ubuntu14.04-ansible:stable
MAINTAINER Mark Stillwell <mark@stillwell.me>

COPY . /var/cache/docker/glance
WORKDIR /var/cache/docker/glance

RUN if [ ! -f playbooks/group_vars/all.yml ]; then \
      mkdir -p playbooks/group_vars;\
      ln -s ../../defaults/main.yml playbooks/group_vars/all.yml;\
    fi
RUN ansible-playbook -i inventories/local.ini playbooks/install.yml

VOLUME [ "/etc/glance", "/var/lib/glance", "/var/log/glance" ]

CMD sudo -u glance /bin/sh -c "/usr/bin/glance-registry & /usr/bin/glance-api"

EXPOSE 9191 9292
