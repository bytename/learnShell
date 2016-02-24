#########################################################################
# Copyright (c) 2009-~ byte~~
# 
# This source code is released for free distribution under the terms of the
# GNU General Public License
# 
# Author:    byte~~
# File Name: copy_file.sh
# Description:需要把跨服更新的文件放在统一的GS600目录中 
#########################################################################
#!/bin/bash
allpath="/data/cool/rAll"
onepath="/data/cool/4-101"
twopath="/data/cool/102-200"
newpath="/data/cool/GS600"
copydirectory(){
echo "复制更新文件夹到相应的目录"
for i  in `ls -l  $newpath  | grep "^d" | awk '{print $9}'` 
do
	if [[ -d  $newpath/$i ]];then
		cp -R  $newpath/$i     $allpath && \
		cp -R  $newpath/$i     $onepath && \
		cp -R  $newpath/$i     $twopath
		[[ $? -eq 0 ]] && echo "复制$i文件成功!"  || echo "复制$i失败!"
	else
		exit 4
	fi
done
}
copyexe(){
echo "复制更新程序到相应的目录中"
for d in `ls -l $newpath  | grep -v  "^d" | awk '{print $9}'`
do
	case "$d" in 
	"InterAllSvr")
	cp  $newpath/$d  $allpath  && \
	[[ $? -eq 0 ]] && echo "复制$d程序到$allpath"  || echo "复制$d失败!"
	;;
	"InterOtherSvr")
	cp  $newpath/$d  $allpath  &&  \
	[[ $? -eq 0 ]] && echo "复制$d程序到$allpath"  || echo "复制$d失败!"
	;;
	"InterDataSvr")
	cp $newpath/$d  $onepath && \
	cp $newpath/$d  $twopath  && \
	[[ $? -eq 0 ]] && echo -e "复制$d程序到$onepath\n复制$d程序到$twopath"|| echo "复制$d失败!"
	;;
	"InterSvr")
	cp $newpath/$d  $onepath &&  \
	cp $newpath/$d  $twopath &&  \
	. "$onepath"/cp_Game.sh $onepath  &&  \
	. "$twopath"/cp_Game.sh $twopath  &&  \
	[[ $? -eq 0 ]] && echo -e  "复制$d程序到$onepath\n复制$d程序到$twopath\n运行copy脚本"  || echo "复制$d失败!"
	;;
	esac
done
}
main(){
	copydirectory && copyexe
}
main
