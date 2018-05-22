.. title: KDE
.. slug: kde
.. date: 2014/04/08 08:34:18
.. description:
.. category: computer
.. tags: linux, kde
.. link:

大約 2012 年 11 月，正式開始了 linux 之旅。一開始用的是 Archlinux，到現在還是用它。

桌面，一直用的是 LXDE，後來換成 GNOME 3.10 約 2 個星期，又換到 KDE。
到了 KDE 才發現 linux 的桌也可以做得很好用。現階段的 KDE，比 GNOME 穩定得多，也比較好看、有質感。

記錄一下我的 KDE 系統。

Install
=======

上一次是為了 digikam，這次為了這個什麼電子書都可以看的 kdegraphics-okular，還是把 kde 裝上了。
digikam 就不用了，因為用起來實在是太笨重，還是選擇其它的方式：dophine + gwenview，具有管理和看圖的功能。
::

    yaourt -S --needed --noconfirm kdebase kdebase-workspace kde-l10n-zh_tw oxygen-gtk{2,3} kde-gtk-config yakuake kdegraphics-ksnapshot kdegraphics-okular kdeutils-ark p7zip zip unzip unrar kio-mtp fcitx-im fcitx-table-extra fcitx-chewing kdeplasma-addons-applets-kimpanel kcm-fcitx fcitx-qt5 kdegraphics-gwenview kdemultimedia-kmix kdemultimedia-ffmpegthumbs kid3 cantata cdparanoia

Configuration
=============

讓 qt 和 gtk 程式看起來一致
---------------------------

在 kde 下執行 gtk 程式，真是太醜了，不改不行。

`Archlinux Wiki <https://wiki.archlinux.org/index.php/Uniform_Look_for_Qt_and_GTK_Applications>`_ 中,
提到了 qtcurve，gtk-qt-engine 可惜都不適用。

qtcurve 的樣子看起來是不錯，可惜，不支援 gtk3。造成 gtk3 的程式還是醜。

最後，選用了 `oxygen-gtk`_ 的解決方案。

.. code::

    $ yaourt -S oxygen-gtk{2,3} kde-gtk-config

.. _oxygen-gtk: https://wiki.archlinux.org/index.php/Uniform_Look_for_QT_and_GTK_Applications#Styles_for_both_Qt_and_GTK.2B

設定 qt4 程式外觀
-----------------

執行
::

    qtconfig-qt4

修改 appearance 和 fonts，vlc 和 qbittorrent 顯示才看起來正常。

stop akonadi
------------------------------------------------------------------------

參考 http://userbase.kde.org/Akonadi/zh-tw#ApplicationTable

.. code::

    akonadictl stop
    sudo systemctl stop mysqld
    sudo systemctl disable mysqld

修改 ``~/.config/akonadi/akonadiserverrc``

.. code::

    StartServer=false

cursor theme
------------------------------------------------------------------------

參考：https://wiki.archlinux.org/index.php/Cursor_Themes

不知道什麼原因，滑鼠游標的型狀，老是會變成 x 的游標主題，做個小小的軟連結，讓游標好看一點。
但我相信這個不是正解，只是 google 了好久，總找不到根本解法，先治標吧。

.. code::

    $ mkdir ~/.icons
    $ ln -s /usr/share/icons/default.kde4 ~/.icons/default
    # mkdir -p /usr/share/icons/default
    # nano /usr/share/icons/default/index.theme

    [icon theme]
    Inherits=Oxygen_Black

中文輸入法：嘸蝦米
------------------------------------------------------------------------

參看 :doc:`ibusfcitxshu-ru-fa-she-ding`

字型設定:
-------------------------------------------------------------------------

先 copy windows 下的字型檔，我選擇的是微軟雅黑和中黑，比較好看。``msjh.ttf msjhbd.ttf``。
再安裝其它字型相關的程式與字型。
::

    $ yaourt -S {freetype2, fontconfig}-infinality-git ttf-tw ttf-dejavu ttf-google-fonts-git ttf-liberation ttf-arphic-{ukai,uming} qy-zenhei

設定 panel
-------------------------------------------------------------------------

自行調整 panel 的位置、大小、內容。

設定 kde 的快速鍵：
-------------------------------------------------------------------------

全域捷徑

- C-A-T: terminal (konsole)
- C-A-B: browser (google-chrome-stable)
- C-A-F: file manager (dophine)
- C-A-E: editor:kate or geany, now I use kate for text editing.
- C-A-M: music player (cantata)
- M-{1,2,3,4}：切換到桌面 n
- M-S-{1,2,3,4}：移動目前工作視窗到桌面 n

常用軟體說明
========================================================================

kde 有表列一些應用程式, 參看 `這裡 <http://www.kde.org/applications/>`_

yakuake: 下拉式的終端機，酷。設定>一般>指令，要設定： ``/bin/bash``。

digikam kipi-plugins：就是這個「相片管理」程式，讓我第一次安裝了 kde。不過現在不用了，因為太大、太笨重的感覺。

kdegraphics-gwenview：比較快速的 viewer，搭配 dolphine 就很好用了。

kdegraphics-kolourpaint：KDE 下的小畫家

kdegraphics-ksnapshot：KDE 的螢幕擷取程式

kdeutils-ark p7zip zip unzip unrar：解壓縮檔。

kdegraphics-okular：kde 預設的文件閱讀器，功能強大，可以看 epub 和 pdf 的軟體，就是這個讓我繼續用 KDE。

kdemultimedia-kmix: 音量控控器，配合 mpdris2 可以控制 mpd 的音量和播放。

kdemultimedia-ffmpegthumbs: 讓影片檔也有縮圖。

kio-mtp: HTC android mobile-phone support on KDE Dolphin

kdeplasma-applets-yawp: 看天氣的小東西。

systemd user session management
=====================================================================

使用 xlogin-git，參看 :doc:`autologin-without-dm`

上次裝的時候，為了要自動 login，加了 getty@tty1.service，這個記得要刪掉，不然會衝突到不知如何除錯，
如果不是這次要重裝，也不會發現原來還有這個問題
::

    systemctl disable getty@tty1.service

問題與解法
===============================================================

每次 login 都會重新建立一個「新活動」
----------------------------------------------------------------

找到下面 2 個檔，刪掉，讓 KDE 重建：
::

    ~/.kde4/share/config/activitymanager-pluginsrc
    ~/.kde4/share/config/activitymanagerrc

開啟以下的檔案，
::

    ~/.kde4/share/config/plasma-desktoprc

找到
``/usr/share/apps/plasma-desktop/updates/addShowActivitiesManagerPlasmoid.js,``
，刪掉。

這樣子還是不會好。後來是重裝 kde 才好。
