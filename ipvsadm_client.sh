#########################################################################
# Copyright (c) 2009-~ byte~~
# 
# This source code is released for free distribution under the terms of the
# GNU General Public License
# 
# Author:    byte~~
# File Name: ipvsadm_client.sh
# Description: 
#########################################################################
#!/bin/bash
. /etc/init.d/functions
VIP="172.16.2.99"
IFCONFIG="/sbin/ifconfig"
function usage(){
    if [[ $# -ne 1 ]];then
	echo "Usage:bash $0 [start | restart | stop]"
	exit 1
    fi
}

function ipvsadmstart(){
    $IFCONFIG lo:11  $VIP  netmak 255.255.255.255 up
    echo "1" >/proc/sys/net/ipv4/conf/lo/arp_ignore
    echo "2" >/proc/sys/net/ipv4/conf/lo/arp_announce
    echo "1" >/proc/sys/net/ipv4/conf/all/arp_ignore
    echo "2" >/proc/sys/net/ipv4/conf/all/arp_announce
    [[ $? -eq 0 ]] && action "ipvsadm_client start"     /bin/true
}

function ipvsadmstop(){
    $IFCONFIG lo:11 $VIP  netmak 255.255.255.255 down
    echo "0" >/proc/sys/net/ipv4/conf/lo/arp_ignore
    echo "0" >/proc/sys/net/ipv4/conf/lo/arp_announce
    echo "0" >/proc/sys/net/ipv4/conf/all/arp_ignore
    echo "0" >/proc/sys/net/ipv4/conf/all/arp_announce
    [[ $? -eq 0 ]] && action "ipvsadm_client stop"     /bin/true
}

function main(){
    usage $1
    case $1  in
	"start")
	    ipvsadmstart
	    ;;
	"stop")
	    ipvsadmstop
	    ;;
	"restart")
	    ipvsadmstop
	    ipvsadmstart
	    ;;
	"*")
	    echo "Usage:bash $0 [start | restart | stop]"
    esac

}

main $*




