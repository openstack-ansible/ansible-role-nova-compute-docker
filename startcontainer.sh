#!/bin/sh
sysctl net.ipv4.conf.all.rp_filter=0
sysctl net.ipv4.conf.default.rp_filter=0
ovs-vsctl --may-exist add-br br-int
/usr/bin/supervisord
