.. link:
.. title: Install Arch Linux
.. slug: install-arch-linux
.. tags: Linux
.. date: 2013/11/01 09:31:11
.. description:


原則上，跟着 `Beginners' Guide <https://wiki.archlinux.org/index.php/Beginners'_Guide>`_ 做即可。

.. TEASER_END: more

製作開機片（CD、USB、硬碟）啓動
========================================================================

從 Arch Linux Downloads 下載 archlinux.iso，建議用 bt.

參考 https://wiki.archlinux.org/index.php/USB_flash_installation_media 製作開機片
::

  # dd bs=4M if=/path/to/archlinux.iso of=/dev/sdx status=progress && sync


啟動 ArchLinux 安裝程序
========================================================================

選擇從主菜單選擇 "Boot Arch Linux" 並按<enter>，系統將加載並給出登錄提示，自動以 'root' 登錄。

建立網絡連接
========================================================================

確定網路介面
--------------------------------------------------------------

新的 udev 不再用 eth0，wlan0 這種名字，所以要先確認一下網路介面的名稱。

::

    # ip link
    1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT
        link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    2: enp3s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP mode DEFAULT qlen 1000
        link/ether 00:26:18:14:61:03 brd ff:ff:ff:ff:ff:ff
    3: wlp2s0u1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT qlen 1000
        link/ether 20:cf:30:a1:f9:f2 brd ff:ff:ff:ff:ff:ff

ADSL 連線
--------------------------------------------------------------

::

    # pppoe-setup
    name: 86559366@...
    eth0: enp3s0
    value: no
    server: 168.95.1.1
    server: 8.8.8.8
    passwd: p**
    repasswd: p**
    firewall: 1
    y/n: y
    # pppoe-start

準備磁碟機
=======================================================================

partition
--------------------------------------------------------------

可用 gparted live CD 或 windows 中先處理

原則上可以先分出
::

   /           15G
   /home

Q. how to 4K aligned with gparted?

A. 用 gparted, 選 Mib 對齊即可。

檢查分區狀況
--------------------------------------------------------------
::

    # lsblk -f

建立 swap
--------------------------------------------------------------
現在的 RAM 都很大，這個可以不用裝了
::

    # mkswap /dev/sdaX
    # swapon /dev/sdaX

建立 swap file
--------------------------------------------------------------
如果真的要裝 swap，用檔案取代，方便好管理。

::

    # fallocate -l 1G /swapfile
    # sudo chmod 600 /swapfile
    # mkswap /swapfile
    # sudo mkswap /swapfile
    # swapon /swpfile
    # sudo swapon /swapfile
    # sudo nano /etc/fstab

加入
::

    /swapfile none swap defaults 0 0

Remove swap file
----------------------------------------------------------------

如果不用 swap，刪了就是。

**Warning:** swap is managed by systemd and will be reenabled by it after some time.
To remove a swap file, the current swap file must be turned off.
::

    # swapoff -a
    # rm -f /swapfile

掛載分區
--------------------------------------------------------------

先掛載 root 區
::

    # mount /dev/sdaX /mnt

再掛載其他分區，/home 最好獨立分區。
::

    # mkdir /mnt/home
    # mount /dev/sda1 /mnt/home

配置安裝的環境
========================================================================

DNS setup
--------------------------------------------------------------
::

    # nano /etc/resolv.conf

    nameserver 168.95.1.1
    nameserver 8.8.8.8


選擇安裝鏡像
--------------------------------------------------------------

安裝前需要編輯 /etc/pacman.d/mirrorlist，將最想使用的鏡像放到前面。
::

    # nano /etc/pacman.d/mirrorlist

Arch Linux 官方網站提供 `pacman mirrorlist generator <http://www.archlinux.org/mirrorlist/>`_ 可供使用者查詢。

台灣目前的 server 如下

::

    ## ## Arch Linux repository mirrorlist ## Generated on 2012-11-17 #
    # ## Taiwan, Province of China
    #Server = http://archlinux.cs.nctu.edu.tw/$repo/os/$arch
    #Server = http://shadow.ind.ntou.edu.tw/archlinux/$repo/os/$arch
    #Server = http://ftp.tku.edu.tw/Linux/ArchLinux/$repo/os/$arch

nano 簡單指令
::

    Alt-6：copy line
    C-u：paste
    C-x：exit

原則上，改過 mirrorlist 就執行以下指令：
::

    # pacman -Syy

安裝基本系統
========================================================================
::

    # pacstrap -i /mnt base base-devel

if pacman complains that error:
::

    failed to commit transaction (invalid or corrupted package)

run the following command:
::

    # pacman-key --init && pacman-key --populate archlinux

生成 fstab
---------------------------------------------------------------

這個一定要做，不然後頭會很麻煩。
::

    # genfstab -U -p /mnt >> /mnt/etc/fstab
    # nano /mnt/etc/fstab   # 檢查一下 fstab


Chroot 到新系統，並作基本配置
---------------------------------------------------------------
::

    $ arch-chroot /mnt /bin/bash

配置 pacman
---------------------------------------------------------------
::

    # nano /etc/pacman.conf

爲了安裝 yaourt，到最後空白處加上：
::

    [archlinuxfr]
    SigLevel = Never    # add: 2013/04/28
    Server = http://repo.archlinux.fr/$arch

一般使用者用 [core], [extra] 與 [community]。
如果安裝 Arch Linux x86_64，建議也把 [multilib] 打開，就可以執行 32 bit 和 64 bit 的程式。
（不用 32bits 程式就不必做了）
::

    [multilib]
    Include = /etc/pacman.d/mirrorlist

不過，這次我沒開 [multilib]，沒問題。

更新系統，並安裝 yaourt
-----------------------------------------------------------------
::

    # pacman -Syu
    # pacman -S yaourt

配置系統 Locale
-----------------------------------------------------------------
::

    $ nano /etc/locale.gen

找到
::

    en_US.UTF-8 UTF-8
    zh_TW.xxxx
    zh_CN.xxxx

把以上全部打開。

使 locale 生效
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
::

    $ locale-gen    #使更改生效運行

確認一下 locale
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
::

    $ locale -a     #確認一下開啟的 locale
    $ locale        #目前的 locale

全域 locale 設定：對整個系統有效
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
::

    $ nano /etc/rc.conf

    LANG=en_US.utf8

    $ nano /etc/locale.conf

    LANG=zh_TW.UTF-8
    LC_TIME=zh_TW.UTF-8

更改 console 字型、鍵盤配置：
---------------------------------------------------------------
::

    $ nano /etc/vconsole.conf

    KEYMAP=us
    FONT=
    FONT_MAP=

配置系統時區
---------------------------------------------------------------

可用的時區位於目錄 /usr/share/zoneinfo/ 下，可以 ls 一下。用以下指令配置系統時區：
::

    $ ln -s /usr/share/zoneinfo/Asia/Taipei /etc/localtime

時間調整
---------------------------------------------------------------

為了與 windows 雙重開機 (dual boot)，最好是修改 windows 的登錄檔：

Using regedit, add a DWORD value with hexadecimal value 1 to the registry::

    HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation\RealTimeIsUniversal

或是在 windows 桌面建立一個 \*.reg 檔，double-click::

    Windows Registry Editor Version 5.00

    [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\TimeZoneInformation]
        "RealTimeIsUniversal"=dword:00000001

當然，以上的動作要回到 windows 才能執行。目前在 linux 中，只好執行：
::

    $ timedatectl set-local-rtc false

將 utc 時間寫入 BIOS 中：
::

    $ hwclock --systohc --utc

同步時間 daomon
::

    $ pacman -S openntpd    #啟動/etc/rc.d/openntpd start
    $ ntpd -s               #同步
    $ nano /etc/rc.conf     #後台運行
    添加 DAEMONS=(...@openntpd...)

或一次性同步時間 (ntpdate)
::

    $ yaourt -S ntp
    $ sudo ntpdate -s tw.pool.ntp.org       --再研究一下吧，這個好像不能成功
    $ sudo hwclock -w


設置主機名稱
------------------------------------------------------------
::

    # nano /etc/hostname

加入
::

    hostname

再一次設定網路
========================================================================

這個很重要，不然重開機時，就會沒網路可用。
install the network card that is supposed to be connected to the DSL-Modem into your computer.
After adding your newly installed network card to the modules.conf/modprobe.conf install therp-pppoe package
::

    $ pacman -S rp-pppoe
    $ pppoe-setup

run the pppoe-setup script to configure your connection
After you have entered all the data, you can connect and disconnect your line with
::

    $ systemctl start adsl

and
::

    $ systemctl stop adsl

respectively. The setup is usually easy and straightforward, but feel free to read the manpages for hints.
If you want to automatically 'dial in' at boot, issue command
::

    $ systemctl enable adsl

    or

    $ systemctl disable adsl

to remove auto 'dial in' at boot.

ramdisk，增加 lvm2 到 hooks 中
========================================================================
::

    $ nano /etc/mkinitcpio.conf
    $ mkinitcpio -p linux

Install and configure a bootloader
========================================================================

Install the grub-bios package and then run grub-install:
::

    # pacman -S grub-bios                       ## 安裝 grub-bios
    # grub-install --target=i386-pc --recheck /dev/sda  ## 安裝到 boot 區

自動尋找其它的 OS
--------------------------------------------------------------------

如果有其他的 OS，這個就很重要。
::

    # pacman -S os-prober

自動產生 grub.cfg
--------------------------------------------------------------------
這個一定要做，不然重開機時，就等著進 grub shell。
::

    # grub-mkconfig -o /boot/grub/grub.cfg

重啓
========================================================================
::

    # exit
    # umount /mnt
    # reboot

確認網路連線
----------------------------------------------------------------

root 重啓後，ping 一下看看網路連上了嗎？如果沒有，手動連線。
::

    # ping 8.8.8.8
    # systemctl start adsl

update system（可不做）
-----------------------------------------------------------------
::

    # pacman -Syu


post-installation
========================================================================

設置 Root 密碼並創建一般用戶
------------------------------------------------------------
::

    $ passwd
    $ useradd -m -s /bin/bash  -g users -G video,storage,optical,lp,scanner,games,wheel username
    $ passwd username

安裝 Sudo
------------------------------------------------------------
::

    $ pacman -S sudo
    $ EDITOR=nano visudo

允許 wheel 用戶組成員無密碼使用 sudo：
::

    $ visudo

輸入
::

    %wheel ALL=(ALL) NOPASSWD:ALL

再來是設定 sudo，隨便找一個空白行加上：
::

    username ALL=(ALL) ALL

登出，並以新的用戶名稱登入
---------------------------------------------------------------


聲音 alas
---------------------------------------------------------------

安裝音效驅動，直接用 alas，不要考慮太多。
::

    $ yaourt -S alsa-utils

將帳號加入音效使用權：
::

    $ sudo gpasswd -a username audio

alsa 預設是靜音，手動打開聲音
::

    $ amixer

或者用
::

    $ amixer sset Master unmute

測試一下有沒有聲音
::

    $ speaker-test -c 2

安裝 x11
------------------------------------------------------------------
::

    # pacman -S xorg-server xorg-server-utils mesa mesa-demos

因為要用 xlogin，所以 ``xorg-xinit`` 可以不用裝了。

裝顯卡驅動
---------------------------------------------------------------------

ATi 用戶：

我的顯卡太舊了，用 catalyst 不支援硬體加速，直接裝開源驅動。
::

    $ pacman -S xf86-video-ati

intel 用戶：
::

    $ pacman -S xf86-video-intel libav-intel-driver


virtualbox 中安裝顯卡
::

    $ pacman -S virtualbox-guest-utils


安裝字體
------------------------------------------------------------------
改用 noto 字型 (source-han-sans)
加上 ttf-liberation: 修正部份 PDF 字型，此為 google-chrome 新的依賴。
::

   $ yaourt -S ttf-tw ttf-dejavu ttf-liberation
   $ yaourt -S adobe-source-han-sans-otc-fonts adobe-source-sans-pro-fonts adobe-source-serif-pro-fonts adobe-source-code-pro-fonts

讓 X 可以顯示中文
---------------------------------------------------------------
::

    $ yaourt -S numlockx
    $ nano ~/.xinitrc

    export LANG=zh_TW.UTF-8
    export LC_ALL="zh_TW.UTF-8"

    numlockx &          # 將右邊的數字鍵盤預設爲方向鍵。


安裝桌面
----------------------------------------------------------------

選擇 :doc:`lxde <lxde-pei-zhi>` 或 :doc:`GNOME 3.10 <gnomean-zhuang-ji-lu>` 或 :doc:`kde`

全面轉用 xmonad + lxqt。 :doc:`lxqt`

安裝中文輸入法
----------------------------------------------------------------

沒有選擇，用 fcitx 最好。 :doc:`ibusfcitxshu-ru-fa-she-ding`



install google chrome
--------------------------------------------------------------
::

    $ yaourt -S google-chrome


安裝文字編輯器
-------------------------------------------------------------
現在已經沒有別的選擇了，只能用 emacs 這個神的編輯器，因為她實在是太強大了，
讓我不忍放棄她。
::

   $ yaourt -S emacs


geany 就留在記憶中吧。

修改 geany 補完字詞的快速鍵
-------------------------------------------------------------

:doc:`geany-xin-de`

可用的系統成型了，但是，後面還有許多需要微調的。
