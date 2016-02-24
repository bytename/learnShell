#########################################################################
# Copyright (c) 2009-~ byte~~
# 
# This source code is released for free distribution under the terms of the
# GNU General Public License
# 
# Author:    byte~~
# File Name: scp.sh
# Description:通过scp传递文件脚本 
#########################################################################
#!/bin/bash
#定义变量
PassWord="*****"
ip="******"
#检测是否安装sshpass
install_sshpass(){
	rpm -aq | grep sshpass >>/dev/null
	[[ $?  -eq 0  ]] &&  echo "Checked sshpass is OK!" || yum -y install sshpass
	>>/dev/null
}
#传输文件
scp(){

	sshpass -p"${PassWord}" scp -r -P 10096  -o StrictHostKeyChecking=no  ./"$1"   root@"${ip}":/root/remoteLinux/   
	if [[ $? -eq 0 ]];then
		echo -e "\033[31mSuccess!\033[0m" 
	else
		echo -e "\033[31mFailed!\033[0m"
	fi
}

main()
{
	#检测传值
	if [[  $#  -ne  1  ]];then
		echo -e "\033[31mUsage:bash $0 Filename\033[0m"
		exit 2
	fi
	install_sshpass && scp  $1
}
main $1
