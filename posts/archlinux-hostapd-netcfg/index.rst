.. title: wireless AP 設定 （hostapd+netcfg/netctl）
.. slug: archlinux-hostapd-netcfg
.. date: 2014/03/07 11:13:56
.. tags:
.. link:
.. description:
.. type: text

Update: 2014-10-16

目前已改用netctl了，參考 http://linsir.sinaapp.com/post/Raspberry_Pi_Wifi_Router 設定。

裝上 hostapd，讓我的 HTC 和IPOD 可以上網。

完整的說明參考： http://guildwar23.blogspot.tw/2013/03/notebook-ap-arch-linux.html

安裝
====

.. code::

    $ yaourt -S hostapd dnsmasq netcfg
    $ yaourt -S netctl


配置
====

hostapd 設定檔
--------------

.. code::

    sudo nano /etc/hostapd/hostapd.conf

    interface=wlp0s18f2u1u4
    ssid=xxxxxxxx
    hw_mode=g
    channel=1
    wpa=2
    wpa_psk=b619ecf4c68e7d688e1a29cf2809ec3556a289eb655b859a893ae16933296f18
    wpa_key_mgmt=WPA-PSK
    rsn_pairwise=CCMP


dnsmasq 設定檔
--------------

.. code::

    $ sudo nano /etc/dnsmasq.conf

    port=0
    interface=wlp0s18f2u1u4
    listen-address=192.168.199.254
    dhcp-range=192.168.199.101,192.168.199.150,12h
    dhcp-option=6,168.95.192.1,168.95.1.1


netcfg 設定檔
-------------

.. code::

    sudo nano /etc/network.d/hostapd

    CONNECTION='ethernet'
    DESCRIPTION="wireless ap in master mode with hostapd"
    IP="static"
    ADDR="192.168.199.254"
    INTERFACE=wlp0s18f2u1u4
    SKIPNOCARRIER="yes"

    POST_UP="iptables -I FORWARD -s 192.168.199.0/24 -j ACCEPT; iptables -I FORWARD -d 192.168.199.0/24 -j ACCEPT; iptables -t nat -I POSTROUTING -o ppp0 -s 192.168.199.0/24 -j MASQUERADE; sysctl -w net.ipv4.ip_forward=1; iptables -I INPUT -i wlp2s0u1
     -p udp --dport 67 -j ACCEPT; systemctl start hostapd; systemctl start dnsmasq"

    POST_DOWN="systemctl stop hostapd; systemctl stop dnsmasq; iptables -D FORWARD -s 192.168.199.0/24 -j ACCEPT; iptables -D FORWARD -d 192.168.199.0/24 -j ACCEPT; iptables -t nat -D POSTROUTING -o ppp0 -s 192.168.199.0/24 -j MASQUERADE; sysctl -w net.ipv4.ip_forward=0; iptables -D INPUT -i wlp2s0u1
     -p udp --dport 67 -j ACCEPT"

wifiip
------

設定nat和防火牆的script，注意要用絕對路徑，不然開機時期，會找不到相對應的程式執行。

.. code::

   #!/bin/bash

   interface=wlp0s18f2u1u4

   iptables=/usr/bin/iptables
   ifconfig=/usr/bin/ifconfig
   sysctl=/usr/bin/sysctl

   wifi_on() {
     ${iptables} -I FORWARD -s 192.168.199.0/24 -j ACCEPT
     ${iptables} -I FORWARD -d 192.168.199.0/24 -j ACCEPT
     ${iptables} -t nat -I POSTROUTING -o ppp0 -s 192.168.199.0/24 -j MASQUERADE
     ${sysctl} -w net.ipv4.ip_forward=1
     ${iptables} -I INPUT -i ${interface} -p udp --dport 67 -j ACCEPT
     ${ifconfig} ${interface} 192.168.199.1 netmask 255.255.255.0
   }

   wifi_off() {
     ${iptables} -D FORWARD -s 192.168.199.0/24 -j ACCEPT
     ${iptables} -D FORWARD -d 192.168.199.0/24 -j ACCEPT
     ${iptables} -t nat -D POSTROUTING -o ppp0 -s 192.168.199.0/24 -j MASQUERADE
     ${sysctl} -w net.ipv4.ip_forward=0
     ${iptables} -D INPUT -i ${interface} -p udp --dport 67 -j ACCEPT
     ${ifconfig} ${interface} down
   }

   usage() {
     echo "USAGE: wifiip [on|off]"
   }

   if (( $# > 0 )); then
     case "$1" in
       "on")  wifi_on;;
       "off") wifi_off;;
       *)     usage
              exit 64;;
     esac
     exit 0
   else
     usage
   return 64
   fi

netctl 設定檔
-------------

配置檔 ``/etc/netctl/hostapd``

.. code::

    Description="wireless ap in master mode with hostapd"
    Connection=ethernet
    Interface=wlp0s18f2u1u4
    IP=static
    Address="192.168.199.254"
    SkipNoCarrier="yes"

    ExecUpPost="/bin/wifiip on"
    ExecDownPre="/bin/wifiip off"


啟動
====

以下分別為啟動、重啟、停止、開機啟動


啟動：
------

.. code::

    $ sudo netctl start hostapd

    $ sudo netcfg hostapd
    或
    $ sudo systemctl start netcfg@hostapd


關閉:
-----

.. code::

    $ sudo netctl stop hostapd

    $ sudo netcfg down hostapd
    或
    $ sudo systemctl stop netcfg@hostapd


設定systemd
-----------

在 ``dnsmasq.service`` 中修改 ``After=network.target`` 為 ``After=hostapd.service`` ，
確dnsmasq在hostapd之後啟動。 (可能有誤，保留)

enable相關服務：
::

   $ netctl enable hostapd
   $ systemctl enable hostapd
   $ systemctl enable dnsmasq

重開機可以看結果。


註：wpa 的取得
==============

參考： https://wiki.archlinux.org/index.php/WPA_supplicant

安裝：
------

.. code::

    yaourt -S wpa_supplicant

執行：
------

.. code::

    wpa_passphrase essid passphrase

結果
----

.. code::

    network={
        ssid="essid"
        #psk="passphrase"
        psk=f5d1c49e15e679bebe385c37648d4141bc5c9297796a8a185d7bc5ac62f954e3
    }

結論
====

在 archlinux, netcfg 已經進 AUR，取而代之的是 netctl，應該試一試。

netctl在配置上與netcfg幾乎相同，可參閱上文。
