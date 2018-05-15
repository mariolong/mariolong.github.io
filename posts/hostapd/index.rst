.. title: hostapd
.. slug: hostapd
.. date: 2014-10-23 02:18:55 UTC
.. tags:
.. link:
.. description:
.. type: text

先前寫過的 :doc:`archlinux-hostapd-netcfg` ，經過這些天的測試，我發現 netcfg/netctl 是沒有必要的。

上一篇的 hostapd 和 dnsmasq 設定是可用的。但是用 ``netctl enable hostapd`` 是無法在開機時自動啟動「無線 AP」功能。
我想是因為 netctl 和 iptables 不合吧？會出現 xtables lock 的問題，不知道原因。

後來仔細想想，我要做的不過是用 systemd 去設定 iptables，為何一定要用 netctl？
不如自己寫一個 systemd 的 service，用來設定 iptables 就好了。

結論是，成功。現在開機就可自動把無線 AP 開啟。記錄一下這幾個設定檔備查。


安裝
====
::

    $ yaourt -S hostapd dnsmasq wpa_supplicant

配置
====

ip link
-------

先用 ``ip link`` 查 wifi interface

::

   1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1
       link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
       2: enp3s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
       link/ether 00:26:18:14:61:03 brd ff:ff:ff:ff:ff:ff
       3: wlp0s18f2u3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
        link/ether 20:cf:30:a1:f9:f2 brd ff:ff:ff:ff:ff:ff


其中第 3 個 wlp0s18f2u3 即為我的 wifi 卡。

hostapd
-------

就是這個程式，讓我的無線網卡，變身為無線 AP。

配置檔 ``/etc/hostapd/hostapd.conf``

.. code::

    interface=wlp0s18f2u3
    ssid=xxxxxxxx
    hw_mode=g
    channel=1
    wpa=2
    wpa_psk=b619ecf4c68e7d688e1a29cf2809ec3556a289eb655b859xxxxxxxxxx3296f18
    wpa_key_mgmt=WPA-PSK
    rsn_pairwise=CCMP

dnsmasq
-------

配置檔 ``/etc/dnsmasq.conf``

.. code::

    port=0
    interface=wlp0s18f2u3
    listen-address=192.168.199.254
    dhcp-range=192.168.199.101,192.168.199.150,12h
    dhcp-option=6,168.95.192.1,168.95.1.1

wifiip
------

檔名： ``/usr/bin/wifiip``

設定 nat 和防火牆的 script，注意要用絕對路徑，不然開機時期，會找不到相對應的程式執行。

.. code::

    #!/bin/bash

    interface=wlp0s18f2u3

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


wifiip.service
--------------

簡單地寫一下，可用就好。
::

    [Unit]
    Description=wifi ap via usb dongle
    After=hostapd.service dnsmasq.service

    [Service]
    ExecStart=/usr/bin/wifiip on

    [Install]
    WantedBy=multi-user.target


命令別名
--------

在 ``.bashrc`` 中設定別名

::

    alias wifion='sudo /bin/wifiip on; sudo systemctl start hostapd; sudo systemctl start dnsmasq'
    alias wifioff='sudo systemctl stop hostapd; sudo systemctl stop dnsmasq; sudo /bin/wifiip off'

只要在命令列中執行 ``wifion/wifioff`` 隨時都可以開啟/關閉「無線 AP」。

開機時自動啟動 daemon
---------------------

執行：
::

   $ sudo systemctl enable hostapd
   $ sudo systemctl enable dnsmasq
   $ sudo systemctl enable wifiip

分別開啟這幾個服務，重開機時就可以看到成果囉。

註：wpa 的取得
==============

參考：https://wiki.archlinux.org/index.php/WPA_supplicant

安裝：
------

.. code::

    yaourt -S wpa_supplicant

執行：
------

.. code::

    $ wpa_passphrase essid passphrase

結果
----

.. code::

    network={
        ssid="essid"
        #psk="passphrase"
        psk=f5d1c49e15e679bebe385c37648d4141bc5c9297796a8a185d7bc5ac62f954e3
    }
