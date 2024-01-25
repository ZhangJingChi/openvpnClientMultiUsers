#!/bin/sh
#linux shell openvpn script to create multiple user ovpn files(for example:300-310)
#批量生成命名为300~310的ovpn文件
nameBegin=300
nameEnd=310

for((CLIENT=$nameBegin;CLIENT<=$nameEnd;CLIENT++)); 

do  

cd /etc/openvpn/easy-rsa/

./easyrsa --batch build-client-full $CLIENT nopass

cp /etc/openvpn/client-template.txt ~/$CLIENT.ovpn

echo "<ca>" >>~/$CLIENT.ovpn

cat "/etc/openvpn/easy-rsa/pki/ca.crt" >>~/$CLIENT.ovpn

echo "</ca>" >>~/$CLIENT.ovpn

echo "<cert>" >>~/$CLIENT.ovpn

awk '/BEGIN/,/END CERTIFICATE/' "/etc/openvpn/easy-rsa/pki/issued/$CLIENT.crt" >>~/$CLIENT.ovpn

echo "</cert>" >>~/$CLIENT.ovpn

echo "<key>" >>~/$CLIENT.ovpn

cat "/etc/openvpn/easy-rsa/pki/private/$CLIENT.key" >>~/$CLIENT.ovpn

echo "</key>" >>~/$CLIENT.ovpn

echo "<tls-crypt>" >>~/$CLIENT.ovpn

cat /etc/openvpn/tls-crypt.key >>~/$CLIENT.ovpn

echo "</tls-crypt>" >>~/$CLIENT.ovpn

done 


