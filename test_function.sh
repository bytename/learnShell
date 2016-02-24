#########################################################################
# Copyright (c) 2009-~ byte~~
# 
# This source code is released for free distribution under the terms of the
# GNU General Public License
# 
# Author:    byte~~
# File Name: test_function.sh
# Description: 测试/etc/init.d/functions用法
#########################################################################
#!/bin/bash
#vip="172.16.2.62"
#subnet="eth0:`echo $vip | cut -d . -f4`"
#function checksub(){
 #   ifconfig | grep $1 | wc -l
#}


#if [[  $(checksub $subnet) -ne 0  ]];then
#    echo "不等于0"
#fi






#array=(
#    192.3.4.5
#    192.3.4.6
#    192.3.4.7
#    192.3.4.8
#    192.3.4.9
#    192.3.4.10
#)
#for((i=0;i<${#array[*]};i++))
#do
#    echo ${array[i]}
#done


#echo "=========================="
#for data in ${array[@]}
#do
#    echo ${data}
#done

arr="sdfdsfdlj"
echo ${arr#/lj}







