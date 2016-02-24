#########################################################################
# Copyright (c) 2009-~ byte~~
# 
# This source code is released for free distribution under the terms of the
# GNU General Public License
# 
# Author:    byte~~
# File Name: iptables.sh
# Description: 添加和删除防火墙
#########################################################################
#!/bin/bash
add_tcp_port=(3306)  #数组(端口号)
rule=$2
protocol=$3
jump=$4
check_error()
{
    if [[ $? -eq 0 ]];then
	echo  -e "\033[31mSuccess!\033[0m"
    else
	echo -e  "\033[31mfailed!\033[0m"
    fi
}
add()
{
    for((i=0;i<${#add_tcp_port[*]};i++))
    do
	iptables -A ${rule} -p ${protocol} --dport ${add_tcp_port[i]} -j ${jump}
    done
    check_error
}
del()
{
    for((i=0;i<${#add_tcp_port[*]};i++))
    do
	iptables -D ${rule} -p ${protocol} --dport ${add_tcp_port[i]} -j ${jump}
    done
    check_error
}
help()
{
        echo "#================================help========================================#"
	echo "#sh iptables.sh [add|del] [INPUT|FORWORD|OUTPUT] [udp|tcp] [ACCEPT|DROP]     #"
	echo "#args                                                                        #" 
	echo "#add:add iptables rules                                                      #"
	echo "#del:delete iptables rules                                                   #"
	echo "#example:添加规则                                                            #"
	echo "#bash iptables.sh  add  INPUT  tcp ACCEPT                                    #"
	echo "#============================================================================#"
}
main()
{
    if [[ $# -ne 4 ]];then
	help
	exit 1
    fi
    case $1 in
	"add")
	    add $2 $3 $4
	    ;;
	"del")
	    del $2 $3 $4
	    ;;
	"*")
	    help
	;;
    esac
}
main $@
