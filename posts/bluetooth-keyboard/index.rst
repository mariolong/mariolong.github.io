.. title: 藍牙小鍵盤
.. slug: bluetooth-keyboard
.. date: 2014/06/27 09:06:38
.. tags: Linux
.. link:
.. description:
.. type: text

本文參考 `archlinux wiki: Bluetooth Keyboard <https://wiki.archlinux.org/index.php/Bluetooth_Keyboard>`_

Install
=======
::

   $ yaourt -S bluez bluez-utils

配置
====

配置的工作主要是配對和自動連上藍牙鍵盤。

配對
----

用 ``bluetoothctl -a`` 執行配對的工作，按照下列的指令，一步一步執行即可。
::

   $ bluetoothctl -a
   [bluetooth]# power on
   [bluetooth]# agent KeyboardOnly
   [bluetooth]# default-agent
   [bluetooth]# pairable on
   [bluetooth]# scan on
   [bluetooth]# pair 01:02:03:04:05:06
   [bluetooth]# trust 01:02:03:04:05:06
   [bluetooth]# connect 01:02:03:04:05:06
   [bluetooth]# quit

執行到 ``scan`` 時，鍵盤必須是在可配對模式。

執行到 ``pair`` 時，會出現配對碼，這時候要在藍牙鍵盤上輸入配對碼，再按 <enter>。哈哈，配對完成。

其它的步驟就簡單啦。

開機時自動連上藍牙鍵盤
----------------------

為了能讓鍵盤開機後就可以使用，必須執行 2 個 systemd service： ``bluetooth.service`` 和 ``btkbd.service`` 。
其中 ``bluetooth.service`` 安裝 ``bluez`` 時會產生， ``btkbd.service`` 就得自己建立。

啟動 ``bluetooth.service``
~~~~~~~~~~~~~~~~~~~~~~~~~~
::

   systemctl enable bluetooth.service

這個步驟很重要，因為它會自動建立 ``dbus-org.bluez.service`` 連結，而這個連結是 ``btkbd.service`` 需要的程式。

建立 ``btkbd.service``
~~~~~~~~~~~~~~~~~~~~~~

為了要建立這個 ``service`` ，我們要知道鍵盤的 MAC 和 藍牙接收器的 id，分別用 ``bluetoothctl`` 和 ``hcitool`` 這 2 隻程式取得。

取得 id
+++++++
::

   $ hcitool dev
   Devices:
           hci0	00:15:83:43:C8:EA

此處的 ``hci0`` 即為藍牙接收器的 id。

另外鍵盤的 MAC，在用 ``bluetoothctl`` 配對鍵盤時，就已經知道了，此時調出來看一下就好。
::

   $ bluetoothctl
   [NEW] Controller 00:15:83:43:C8:EA arch-64 [default]
   [NEW] Device 20:13:50:00:1F:E2 Bluetooth Keyboard

第二行的那 6 個數字即是我們要的 MAC。

建立 ``/etc/btkbd.conf``
++++++++++++++++++++++++
::

   # Config file for btkbd.service
   # change when required (e.g. keyboard hardware changes, more hci devices are connected)
   BTKBDMAC = 20:13:50:00:1F:E2
   HCIDEVICE = hci0

建立 ``/etc/systemd/system/btkbd.service``
++++++++++++++++++++++++++++++++++++++++++
::

   [Unit]
   Description=systemd Unit to automatically start a Bluetooth keyboard
   Documentation=https://wiki.archlinux.org/index.php/Bluetooth_Keyboard
   Requires=dbus-org.bluez.service
   After=dbus-bluez.org.service
   ConditionPathExists=/etc/btkbd.conf
   ConditionPathExists=/usr/bin/hcitool
   ConditionPathExists=/usr/bin/hciconfig

   [Service]
   Type=oneshot
   EnvironmentFile=/etc/btkbd.conf
   ExecStart=
   ExecStart=/usr/bin/hciconfig ${HCIDEVICE} up
   # ignore errors on connect, spurious problems with bt? so start next command with -
   ExecStart=-/usr/bin/hcitool cc ${BTKBDMAC}

啟動鍵盤服務
++++++++++++
::

   $ sudo systemctl enable btkbd

至此，開機即可享受到藍牙鍵盤的無線魅力。如果，要省電，用完鍵盤後，即可關掉電源。
等到要用時，再把電源打開，讓它自動連上主機，再為我們服務囉。

結語
====

一個很有質感的藍牙鍵盤，放在客廳的 HTPC 邊，一點都不會覺得很奇怪。

在配對時，一開始不知道要在鍵盤上輸入配對碼，只是一直等待，所以，一直沒辦法使用。
在手冊上突然看到了一句話，就這樣連線成功。當我在藍牙鍵盤上按下按鍵，在螢幕上看到了相對應的字出現時，真是開心啊。

Linux 就是這樣好玩。

**update:2014-7-9**

不知道什麼原因，用 systemd 的方法，第一次試是成功的，後來就不知何種原因，怎麼都無法啟動。
算了，我也不想深究。

直接用另一個方法，比較簡單，有 udev 即可。
參考 `archlinux wiki <https://wiki.archlinux.org/index.php/Bluetooth#Configuration_via_the_CLI>`_

先用 bluetoothctl 將藍牙鍵盤配對好，記住 hci device 的編號 (hci0)，再在 udev 增加一條規則：
編輯 /etc/udev/rules.d/10-local.rules
::

   # Set bluetooth power up
   ACTION=="add", KERNEL=="hci0", RUN+="/usr/bin/hciconfig hci0 up"


這樣子開機就會自動載入藍牙鍵盤。
