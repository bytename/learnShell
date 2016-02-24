#########################################################################
# Copyright (c) 2009-~ byte~~
# 
# This source code is released for free distribution under the terms of the
# GNU General Public License
# 
# Author:    byte~~
# File Name: ipvsadm_server.sh
# Description: 
#########################################################################
#!/bin/bash
. /etc/init.d/functions
VIP="172.16.2.99"
PORT="80"
SUBNET="eth0:`echo $VIP |cut -d . -f4`"
GW="172.16.2.245"


#real server
RIP=(
    172.16.2.63
    172.16.2.61
)

IFCONFIG="/sbin/ifconfig"
IPVSADM="/sbin/ipvsadm"
ARPING="/sbin/arping"
#use bash
function usage(){
    local script_name
    script_name=$1
    echo "Usage :$script_name [ start | stop | restart ]"
    echo ""
    exit 1
}
function checkCmd(){
if [ ! -f $1  ];then
    echo "can't find $1"
    return 1
fi
}
function checksubnet(){
    $IFCONFIG | grep $1 | wc -l
}

function ipvsStart(){
    if [[  $(checksubnet $SUBNET) -ne 0  ]];then
	echo $IFCONFIG $SUBNET down
    fi
    #定义局部变量
    local rs 
    #添加虚拟网卡
    $IFCONFIG $SUBNET $VIP broadcast $VIP netmast 255.255.255.0 up 
    $IPVSADM -C
    $IPVSADM -A -t $VIP:$PORT -s wrr -p 60
    for((i=0;i<${#RIP[*]};i++))
    do
	$IPVSADM -a -t $VIP:$PORT -r ${RIP[i]}:$PORT -g -w 1
    done
    rs=$?
    $ARPING -c 1 -I $(echo $SUBNET | awk -F ":" '{print $1}') -s $VIP $GW >>./log.log
    [[  $rs -eq  0   ]] && action "Ipvsadm start"  /bin/true
    return $rs
}
function ipvsStop(){
   # local rs
    #rs=1
    $IFCONFIG  $SUBNET down
    $IPVSADM  -C
    $IPVSADM  -Z
    $ARPING -c 1 -I $(echo $SUBNET | awk -F ":" '{print $1}') -s $VIP $GW >/dev/null 2>&1
    [[  $?  -eq 0  ]] && action "Ipvsadm stop"  /bin/true
}

main(){
    if [[  $# -ne  1  ]];then 
	usage $0
    fi
    case $1 in
	"start")
	    ipvsStart
	    ;;
	"stop")
	    ipvsStop
	    ;;
	"restart") 
	    ipvsStop
	    ipvsStart
	    ;;
	   "*")
	    usage $0
	    ;;
    esac
}


main $*








