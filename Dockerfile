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
RUN apt-get -y install curl && curl -sSL https://get.docker.com/ubuntu/ | sudo sh && \
    mkdir -p /var/run/docker /var/log/docker && \
    echo "DOCKER_OPTS=\"--host=unix:///var/run/docker/docker.sock --mtu=1454\"" > /etc/default/docker && \
    echo "DOCKER_LOGFILE=/var/log/docker/docker.log" >> /etc/default/docker && \
    ln -sf docker/docker.sock docker.sock
RUN ansible-playbook -i inventories/local.ini provisioning/install.yml
RUN chmod 755 ./startcontainer.sh

# FIXME: add libvirtd and openvswitch configs and logs
VOLUME [ "/etc/nova", "/var/lib/nova", "/var/log/nova", \
         "/etc/neutron", "/var/lib/neutron", "/var/log/neutron", \
         "/var/run/docker", "/var/lib/docker", "/var/log/docker", \
         "/etc/supervisor", "/var/log/supervisor" ]

CMD [ "./startcontainer.sh" ]
