FROM ansible/ubuntu14.04-ansible:stable
MAINTAINER Mark Stillwell <mark@stillwell.me>

# avoid version problems, possibly caused by juno rollout
RUN rm /etc/apt/sources.list.d/proposed.list && apt-get update

COPY . /var/cache/docker/nova-compute
WORKDIR /var/cache/docker/nova-compute

RUN if [ ! -f provisioning/group_vars/all.yml ]; then \
      mkdir -p provisioning/group_vars;\
      ln -s ../../defaults/main.yml provisioning/group_vars/all.yml;\
    fi
RUN ansible-playbook -i inventories/local.ini provisioning/install.yml
RUN chmod 755 ./startcontainer.sh

VOLUME [ "/etc/nova", "/var/lib/nova", "/var/log/nova", \
         "/var/log/supervisor" ]

CMD [ "./startcontainer.sh" ]
