FROM ansible/ubuntu14.04-ansible:stable
MAINTAINER Mark Stillwell <mark@stillwell.me>

# avoid version problems, possibly caused by juno rollout
RUN rm /etc/apt/sources.list.d/proposed.list && apt-get update

COPY . /var/cache/docker/nova-compute
WORKDIR /var/cache/docker/nova-compute

RUN if [ ! -f playbooks/group_vars/all.yml ]; then \
      mkdir -p playbooks/group_vars;\
      ln -s ../../defaults/main.yml playbooks/group_vars/all.yml;\
    fi
RUN ansible-playbook -i inventories/local.ini playbooks/install.yml

VOLUME [ "/etc/nova", "/var/lib/nova", "/var/log/nova", \
         "/var/log/supervisor" ]

CMD [ "/usr/bin/supervisord" ]

EXPOSE 6080
