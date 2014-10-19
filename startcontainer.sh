#!/bin/sh
sysctl net.ipv4.conf.all.rp_filter=0
sysctl net.ipv4.conf.default.rp_filter=0
service openvswitch-switch start
ovs-vsctl --may-exist add-br br-int
ovs-vsctl set bridge br0 datapath_type=netdev
iptables -A INPUT -i eth0 -j DROP
iptables -A FORWARD -i eth0 -j DROP
/usr/bin/supervisord
