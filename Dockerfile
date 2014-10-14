FROM ansible/ubuntu14.04-ansible:stable
MAINTAINER Mark Stillwell <mark@stillwell.me>

COPY . /var/cache/docker/nova
WORKDIR /var/cache/docker/nova

# workaround, some kind of versioning problem in nova...
RUN rm /etc/apt/sources.list.d/proposed.list && apt-get update

RUN if [ ! -f playbooks/group_vars/all.yml ]; then \
      mkdir -p playbooks/group_vars;\
      ln -s ../../defaults/main.yml playbooks/group_vars/all.yml;\
    fi
RUN ansible-playbook -i inventories/local.ini playbooks/install.yml

VOLUME [ "/etc/nova", "/var/lib/nova", "/var/run/nova", "/var/lock/nova", \
         "/var/log/nova", "/var/log/supervisor" ]

CMD [ "/usr/bin/supervisord" ]

EXPOSE 6080 6081 6082 8773 8774 8775
