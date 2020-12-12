# 实现校园网自动认证

## 自动认证

人类是有惰性的，就让我来说说这个惰性，这个惰性啊。。。。直接进入正题。

相信很多人都有这样的感觉，要是当我打开就能自动联网就好了。此脚本不做自动检测，避免手机连不上网。

### 第一步

**安装node.js环境：**

（1）进入官方下载网址：*http://nodejs.cn/download/* 选择相对应的平台版本进行下载安装。

详细安装请参考：https://www.runoob.com/nodejs/nodejs-install-setup.html

（2）检查环境是否安装成功：

检测命令：**node -v ,npm  -v,**如下图：



![1607782732012](C:\Users\Kenny\AppData\Roaming\Typora\typora-user-images\1607782732012.png)

如果出现相对应的版本号就行了。

## 实现流程

step1:在你喜欢的地方或者桌面创建一个文件夹，里面创建一个文件connection.js，并输入以下内容：

```javascript
const os = require('os');
const fetch = require('node-fetch');
const process = require('process');

function getIPAdresss() {
  var interfaces = os.networkInterfaces();
  let WLAN_interface = interfaces.WLAN;
  for (var devName in WLAN_interface) {
    var iface = WLAN_interface[devName];
    if (iface.family === 'IPv4' && iface.address !== '127.0.0.1' && !iface.internal) {
      return iface.address;
    }
  }
}

function getConnect(){
	const myotherip = getIPAdresss();
	fetch("http://111.6.96.83:9999/portalAuthAction.do", {
		  "headers": {
			"accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
			"accept-language": "zh-CN,zh;q=0.9,en;q=0.8,en-GB;q=0.7,en-US;q=0.6",
			"cache-control": "max-age=0",
			"content-type": "application/x-www-form-urlencoded",
			"upgrade-insecure-requests": "1",
			"cookie": "JSESSIONID=D3812F31C353C7379689CE5DE8BBEB21.worker4"
		  },
		  "referrer": "http://111.6.96.83:9999/portalReceiveAction.do?wlanuserip="+myotherip+"&wlanacname=XXU-A07-4F-ME60",
		  "referrerPolicy": "strict-origin-when-cross-origin",
		  "body": "wlanuserip="+myotherip+"&wlanacname=XXU-A07-4F-ME60&chal_id=&chal_vector=&auth_type=PAP&seq_id=&req_id=&wlanacIp=117.159.38.130&ssid=&vlan=&mac=&message=&bank_acct=&isCookies=&version=0&authkey=88----89&url=&usertime=0&listpasscode=0&listgetpass=0&getpasstype=0&randstr=5997&domain=&isRadiusProxy=true&usertype=0&isHaveNotice=0&times=12&weizhi=0&smsid=&freeuser=&freepasswd=&listwxauth=0&templatetype=1&tname=xxxy_pc_portal_V2.0&logintype=0&act=&is189=false&terminalType=&checkterminal=true&portalpageid=124&listfreeauth=0&viewlogin=1&userid=[你的学号]%40xxxylt&authGroupId=&useridtemp=[你的学号]%40xxxylt&passwd=[你的密码]&operator=%40xxxylt",
		  "method": "POST",
		  "mode": "cors"
	}).then(res=>{
		console.log(res)
	});
}

//不知原因上面并不能获取到返回值，所以智能强制自身销毁：
setTimeout(()=>{
	process.exit(0);
},2000)  //两秒后自动结束进程
```

注意：这里需要引入node-fetch这个库，在所创建的文件夹内打开cmd命令终端，使用`npm install node-fetch --save`进行安装使用。

因为所需要连接的服务器网址可能存在偏差，所以要注意修改这些信息：

`wlanacname=XXU-A07-4F-ME60`这个可能不一样，改成和你所在的网址后面所带的。修改格式就是让这个等于认证网址的`wlanacname=*******`，还有就是所带有的body数据，修改上面的这些信息：

`[你的账号]  [你的密码]`，就是直接改成：`userid=2017*****`。

弄好了之后就测试一下，如下图：



![20201212_223831](https://github.com/zhangdege/auto_connection_wlan/blob/master/%E6%A0%A1%E5%9B%AD%E7%BD%91%E8%84%9A%E6%9C%AC/20201212_223831.gif)

可以看到，我们能够成功通过脚本连接上校园网。

那么接下来呢？就是要设置开机自动打开运行脚本进行连接网络。

先写一个.bat的脚本，命名随便命名。写入以下内容：

```po
@echo off
start cmd /k "node "D:\Program Files (x86)\WLANAUTO\connect.js"&&exit"
#这行不要复制进去,D:\Program Files (x86)\WLANAUTO这个是文件路径。
```

然后把这个脚本放到`C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp`这个路径里面。

记得设置电脑的WiFi自动连接。如图：

https://github.com/zhangdege/auto_connection_wlan/blob/master/%E6%A0%A1%E5%9B%AD%E7%BD%91%E8%84%9A%E6%9C%AC/20201212_223831.gif

然后就大功告成了。
