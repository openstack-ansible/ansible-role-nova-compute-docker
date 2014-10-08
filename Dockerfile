FROM ansible/ubuntu14.04-ansible:stable
MAINTAINER Mark Stillwell <mark@stillwell.me>

ENV DEBIAN_FRONTEND noninteractive

COPY . /var/cache/docker/keystone
WORKDIR /var/cache/docker/keystone
RUN mkdir -p roles && ln -snf .. roles/marklee77.keystone
RUN ansible-playbook -i inventories/local.ini deploy.yml \
        -e '{ "mariadb_dockerize_context" : "install" }' && \
    rm -rf private && \
    service keystone stop

VOLUME ["/root", "/etc/keystone", "/var/run/keystone", "/usr/lib/keystone", \
        "/var/log" ]

CMD [ "/usr/sbin/keystone" ]

EXPOSE 35357
