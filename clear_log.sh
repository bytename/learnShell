#########################################################################
# Copyright (c) 2009-~ byte~~
# 
# This source code is released for free distribution under the terms of the
# GNU General Public License
# 
# Author:    byte~~
# File Name: clear_log.sh
# Description:清档脚本------日志 
#########################################################################
#!/bin/bash
id="126"
user="root"
password="**************"
host="127.0.0.1"
cmd_sql="mysql -u"${user}" -p"${password}" -h"${host}""
clear_logDatabase()
{
	$cmd_sql -e "
	USE mydb_gamelog${id};
	TRUNCATE TABLE accountlogin_log;
	TRUNCATE TABLE Activity_log;
	TRUNCATE TABLE BuyMallItem_log_tbl;
	TRUNCATE TABLE clan_log_tbl;
	TRUNCATE TABLE ConsumeFame_log_tbl;
	TRUNCATE TABLE ConsumptionBindRMB_log_tbl;
	TRUNCATE TABLE ConsumptionRMB_log_tbl;
	TRUNCATE TABLE GetFame_log_tbl;
	TRUNCATE TABLE gmcmd_log_tbl;
	TRUNCATE TABLE item_log_tbl;
	TRUNCATE TABLE ProduceRMB_log_tbl;
	TRUNCATE TABLE QPointItem_Log_tbl;
	TRUNCATE TABLE quest_history_tbl;
	TRUNCATE TABLE Quest_log;
	TRUNCATE TABLE quest_now_tbl;
	TRUNCATE TABLE rmb_log;
	TRUNCATE TABLE sgz_test_log_tbl;
	TRUNCATE TABLE update_newuseronline_log_tbl;
	TRUNCATE TABLE update_onlinecount_log_tbl;
	TRUNCATE TABLE update_player_info;
	TRUNCATE TABLE update_rmbgold_log_tbl;
	TRUNCATE TABLE update_useroffline_log_tbl;
	TRUNCATE TABLE usermanage_log_tbl;
	TRUNCATE TABLE useroffline_log_tbl;
	TRUNCATE TABLE userregister_log_tbl;
	TRUNCATE TABLE YellowDiam_log_tbl;
	TRUNCATE TABLE YellowJewelRenew_log_tbl;	
	"
}

main()
{
	start=$(date +%s)
	clear_logDatabase
	end=$(date +%s)
	time=$((${end}-${start}))
	if [[  $?  -eq 0  ]];then
		echo -e "\033[31m success! 花费时间:${time}秒 \033[0m"
	else
		echo -e "\033[31m fiailed! \033[0m"
	fi
}	
main
