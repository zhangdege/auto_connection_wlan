@echo off
::Windows自带的CURL工具 查看版本号 curl --version  windows10 1803之后自带的工具  低版本或者windows7请安装curl后使用此脚本
::curl 7.55.1 (Windows) libcurl/7.55.1 WinSSL
::Release-Date: 2017-11-14, security patched: 2019-11-05
::Protocols: dict file ftp ftps http https imap imaps pop3 pop3s smtp smtps telnet tftp
::Features: AsynchDNS IPv6 Largefile SSPI Kerberos SPNEGO NTLM SSL
::记得修改信息
::学号
set userid=20174103131
::学号
set useridtemp=20174103131
::密码
set passwd=密码
::参考登录网址http://111.6.96.83:9999/portalReceiveAction.do?wlanuserip=10.200.151.164&wlanacname=XXU-A07-4F-ME60
set wlanacname=XXU-A07-4F-ME60
::联通@xxxylt   电信 @xxxydx   移动@xxxyyd
set operator=@xxxylt
for /f "tokens=4" %%a in ('route print ^|findstr 0.0.0.0.*0.0.0.0') do (
 set IP=%%a
)

::在这里这行必须在一行 用法 curl [option] url
curl -H "Connection: keep-alive" -H "Cache-Control:max-age=0" -H "Upgrade-Insecure-Requests: 1" -H "Origin: http://111.6.96.83:9999" -H "Content-Type: application/x-www-form-urlencoded" -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36 Edg/87.0.664.60" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9" -H "Referer: http://111.6.96.83:9999/portalReceiveAction.do?wlanuserip=%IP%&wlanacname=%wlanacname%" -H "Accept-Language:zh-CN,zh;q=0.9,en;q=0.8,en-GB;q=0.7,en-US;q=0.6" -H "Cookie: JSESSIONID=7B9F338869351F67538C2E98293AD4DF.worker2" -X POST -d "wlanuserip=%IP%&wlanacname=XXU-A07-4F-ME60&chal_id=&chal_vector=&auth_type=PAP&seq_id=&req_id=&wlanacIp=117.159.38.130&ssid=&vlan=&mac=&message=&bank_acct=&isCookies=&version=0&authkey=88----89&url=&usertime=0&listpasscode=0&listgetpass=0&getpasstype=0&randstr=4767&domain=&isRadiusProxy=true&usertype=0&isHaveNotice=0&times=12&weizhi=0&smsid=&freeuser=&freepasswd=&listwxauth=0&templatetype=1&tname=xxxy_pc_portal_V2.0&logintype=0&act=&is189=false&terminalType=&checkterminal=true&portalpageid=124&listfreeauth=0&viewlogin=1&userid=%userid%%operator%&authGroupId=&useridtemp=%useridtemp%%operator%&passwd=%passwd%&operator=%operator%" http://111.6.96.83:9999/portalAuthAction.do
echo School net connect is successfully,you are IP address is:%IP%

::假如不想让窗口悬停，可以把下面这句pause去掉
pause