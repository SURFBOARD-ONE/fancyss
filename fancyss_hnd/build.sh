#!/bin/sh

MODULE=shadowsocks
VERSION=`cat ./shadowsocks/ss/version|sed -n 1p`
TITLE=科学上网
DESCRIPTION=科学上网
HOME_URL=Module_shadowsocks.asp

cp_rules(){
	cp -rf ../rules/gfwlist.conf shadowsocks/ss/rules/
	cp -rf ../rules/chnroute.txt shadowsocks/ss/rules/
	cp -rf ../rules/cdn.txt shadowsocks/ss/rules/
	cp -rf ../rules/version1 shadowsocks/ss/rules/version
}

sync_xray_binary(){
	xray_version=`cat ../xray_binary/latest.txt`
	md5_latest=`md5sum ../xray_binary/$xray_version/xray_armv7 | sed 's/ /\n/g'| sed -n 1p`
	md5_old=`md5sum shadowsocks/bin//xray | sed 's/ /\n/g'| sed -n 1p`
	if [ "$md5_latest"x != "$md5_old"x ]; then
		echo update xray binary！
		cp -rf ../xray_binary/$xray_version/xray_armv7 shadowsocks/bin/xray
		
	fi
}

do_build() {
	if [ "$VERSION" = "" ]; then
		echo "version not found"
		exit 3
	fi
	
	rm -f ${MODULE}.tar.gz
	rm -f $MODULE/.DS_Store
	rm -f $MODULE/*/.DS_Store
	tar -zcvf ${MODULE}.tar.gz $MODULE
	md5value=`md5sum ${MODULE}.tar.gz|tr " " "\n"|sed -n 1p`
	cat > ./version <<-EOF
	$VERSION
	$md5value
	EOF
	cat version
	
	DATE=`date +%Y-%m-%d_%H:%M:%S`
	cat > ./config.json.js <<-EOF
	{
	"build_date":"$DATE",
	"description":"$DESCRIPTION",
	"home_url":"$HOME_URL",
	"md5":"$md5value",
	"name":"$MODULE",
	"tar_url": "https://raw.githubusercontent.com/SURFBOARD-ONE/fancyss/master/fancyss_hnd/shadowsocks.tar.gz", 
	"title":"$TITLE",
	"version":"$VERSION"
	}
	EOF
}

do_backup(){
	HISTORY_DIR="../../fancyss_history_package/fancyss_hnd"
	# backup latested package after pack
	backup_version=`cat version | sed -n 1p`
	backup_tar_md5=`cat version | sed -n 2p`
	echo backup VERSION $backup_version
	cp ${MODULE}.tar.gz $HISTORY_DIR/${MODULE}_$backup_version.tar.gz
	sed -i "/$backup_version/d" "$HISTORY_DIR"/md5sum.txt
	echo $backup_tar_md5 ${MODULE}_$backup_version.tar.gz >> "$HISTORY_DIR"/md5sum.txt
}


cp_rules
sync_xray_binary
do_build
do_backup
