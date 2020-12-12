const os = require('os');
const fetch = require('node-fetch');
const process = require('process');

//确保下面body里的userid="学号"和passwd="你的密码"的正确
//我的网址参数：http://111.6.96.83:9999/portalReceiveAction.do?wlanuserip=10.200.151.164&wlanacname=XXU-A07-4F-ME60
//  wlanacname=XXU-A07-4F-ME60这个也是要修改的
//userid  with password也要修改

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

//不知道没什么没有获取到数据
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
		  "body": "wlanuserip="+myotherip+"&wlanacname=XXU-A07-4F-ME60&chal_id=&chal_vector=&auth_type=PAP&seq_id=&req_id=&wlanacIp=117.159.38.130&ssid=&vlan=&mac=&message=&bank_acct=&isCookies=&version=0&authkey=88----89&url=&usertime=0&listpasscode=0&listgetpass=0&getpasstype=0&randstr=5997&domain=&isRadiusProxy=true&usertype=0&isHaveNotice=0&times=12&weizhi=0&smsid=&freeuser=&freepasswd=&listwxauth=0&templatetype=1&tname=xxxy_pc_portal_V2.0&logintype=0&act=&is189=false&terminalType=&checkterminal=true&portalpageid=124&listfreeauth=0&viewlogin=1&userid=你的学号%40xxxylt&authGroupId=&useridtemp=你的学号%40xxxylt&passwd=你的密码&operator=%40xxxylt",
		  "method": "POST",
		  "mode": "cors"
	}).then(res=>{
		console.log(res)
	});
}
getConnect();

//2秒后自动退出
setTimeout(()=>{
	process.exit(0);
},2000)