### XRAY arm二进制存放
***
##### 由于路由器jffs空间有限，此处存放经过UPX压缩的xray二进制，以节约空间<br/>
##### 此处存放的Xray二进制来源于[xray官方项目](https://github.com/XTLS/Xray-core)的[releases页面](https://github.com/XTLS/Xray-core)，仅使用UPX处理，用于路由器下的xray二进制更新<br/>

压缩命令：`upx --lzma --ultra-brute xray xray_armv7 

- 编译采用`go version go1.13.5`版本
- xray提供给fancyss_hnd使用，编译参数为GOARCH=arm, GOARM=7
- xray_armv7提供给fancyss_arm和fancyss_arm384，编译参数为GOARCH=arm, GOARM=5
