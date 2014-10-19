#!/bin/sh
sysctl net.ipv4.conf.all.rp_filter=0
sysctl net.ipv4.conf.default.rp_filter=0
ovsdb-server /etc/openvswitch/conf.db -vconsole:emer -vsyslog:err -vfile:info \
    --remote=punix:/var/run/openvswitch/db.sock \
    --private-key=db:Open_vSwitch,SSL,private_key \
    --certificate=db:Open_vSwitch,SSL,certificate \
    --bootstrap-ca-cert=db:Open_vSwitch,SSL,ca_cert --no-chdir \
    --log-file=/var/log/openvswitch/ovsdb-server.log \
    --pidfile=/var/run/openvswitch/ovsdb-server.pid --detach --monitor 
ovs-vswitchd unix:/var/run/openvswitch/db.sock -vconsole:emer -vsyslog:err \
    -vfile:info --mlockall --no-chdir \
    --log-file=/var/log/openvswitch/ovs-vswitchd.log \
    --pidfile=/var/run/openvswitch/ovs-vswitchd.pid --detach --monitor
ovs-vsctl -- --may-exist add-br br-int -- set bridge br0 datapath_type=netdev
iptables -A INPUT -i eth0 -j DROP
iptables -A FORWARD -i eth0 -j DROP
/usr/bin/supervisord
