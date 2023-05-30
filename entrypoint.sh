#!/bin/sh

UUID=${UUID:-'9f3ce93b-21e3-43c6-835e-5a24613b2fc5'}
VMESS_WSPATH=${VMESS_WSPATH:-"/${UUID}-vmess"}
VLESS_WSPATH=${VLESS_WSPATH:-"/${UUID}-vless"}
TROJAN_WSPATH=${TROJAN_WSPATH:-"/${UUID}-trojan"}
URL=${HOSTNAME}-8080.csb.app

sed -i "s#UUID#$UUID#g;s#VMESS_WSPATH#$VMESS_WSPATH#g;s#VLESS_WSPATH#$VLESS_WSPATH#g" /etc/mysql/config.json
sed -i "s#VMESS_WSPATH#$VMESS_WSPATH#g;s#VLESS_WSPATH#$VLESS_WSPATH#g" /etc/nginx/nginx.conf
sed -i "s#TROJAN_WSPATH#$TROJAN_WSPATH#g;" /etc/mysql/config.json
sed -i "s#TROJAN_WSPATH#$TROJAN_WSPATH#g" /etc/nginx/nginx.conf

rm -rf /usr/share/nginx/*
wget https://github.com/AYJCSGM/mikutap/archive/master.zip  -O /usr/share/nginx/mikutap.zip
unzip -d /usr/share/nginx/ /usr/share/nginx/mikutap.zip
mv /usr/share/nginx/mikutap-master /usr/share/nginx/html
rm -f /usr/share/nginx/mikutap.zip
nginx -s reload

cat > /usr/share/nginx/html/$UUID.html<<-EOF
<html>
<head>
<title>Codesandbox</title>
<style type="text/css">
body {
	  font-family: Geneva, Arial, Helvetica, san-serif;
    }
div {
	  margin: 0 auto;
	  text-align: left;
      white-space: pre-wrap;
      word-break: break-all;
      max-width: 80%;
	  margin-bottom: 10px;
}
</style>
</head>
<body bgcolor="#FFFFFF" text="#000000">
HELLO WORLD .
# <div><font color="#009900"><b>VMESS协议链接：</b></font></div>
# <div>$vmlink</div>
# <div><font color="#009900"><b>VMESS协议二维码：</b></font></div>
# <div><img src="/M$UUID.png"></div>
# <div><font color="#009900"><b>VLESS协议链接：</b></font></div>
# <div>$vllink</div>
# <div><font color="#009900"><b>VLESS协议二维码：</b></font></div>
# <div><img src="/L$UUID.png"></div>
</body>
</html>
EOF

echo https://$URL/$UUID.html > /usr/local/mysql/info
# exec "$@"
