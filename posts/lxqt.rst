.. title: lxqt
.. slug: lxqt
.. date: 2014/04/27 09:06:38
.. tags: linux, lxqt, lxde
.. category: computer
.. link:
.. description:
.. type: text

**update**: 2016/9/19, 2015-5-25, 2014-10-27, 2014-10-15, 2014-10-13, 2014-6-6

lxqt 就是 lxde 的 qt 版？！

可能沒有這麼簡單吧。整個使用的感覺很不錯，比 lxde 容易，預設就好看得多。

**2015-5-25** 這次完全改寫了，原來 lxqt-panel 拿掉，
用 xmonad/taffybar 取代。

.. contents:: 目錄
   :depth: 2

安裝
====
::

   $ yaourt -S lxqt-common lxqt-config lxqt-session lxqt-policykit lxqt-globalkeys lxqt-runner lxqt-qtplugin

裝一些 lxqt 用的常用的軟體
::

   $ yaourt -S pcmanfm-qt gvfs-mtp gvfs-gphoto2 file-roller speedcrunch screengrab gksu

wm 一般都是用 openbox，我喜歡的是 xmonad :doc:`lxqt+xmonad+taffybar`
::

  $ cabal install xmonad xmonad-contrib taffybar

配置
====

修改預設的 wm
-------------

執行 ``lxqt-config-session`` 修改「視窗管理員」。

或修改 ``~/.config/lxqt/session.desktop``
::

   window_manager=xmonad


外觀設定
--------

最重要的是讓 QT 和 GTK 的應用程式看起來很像。參考 `Archlinux Wiki <https://wiki.archlinux.org/index.php/Uniform_Look_for_Qt_and_GTK_Applications#oxygen-gtk>`_

使用 oxygen-gtk 調和 gtk 和 qt 外觀
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
::

   $ yaourt -S oxygen oxygen-{gtk2,icons,cursors} ttf-oxygen

因為 GTK 3.16 之後的版本不再支援 non-CSS themes，所以 oxygen-gtk 的方法就不適用於 GTK3。arch 也把 ``oxygen-gtk3`` 拿掉了。
不用只支援 GTK3 的主題應該就可以。

依據 `Archlinux Wiki <https://wiki.archlinux.org/index.php/Uniform_Look_for_Qt_and_GTK_Applications#oxygen-gtk>`_ 說明，
::

   Note: Before KDE 4.10, you needed to create the file ~/.kde4/share/config/gtkrc-2.0,
   or let it automatically create like described below.
   But that is actually counter-productive with KDE 4.10’s oxygen-gtk,
   and you should delete this file after upgrading to prevent it from messing with your colors.
   Cleanup-removal of ~/.kde4/share/config/gtkrc might be necessary, too.

我把 gtkrc 與 gtkrc-2.0 這兩個檔砍了。

QT5
+++
::

   $ export QT_STYLE_OVERRIDE=gtk
   $ lxqt-config-appearance


QT4
+++
::

   $ export QTCHOOSER_RUNTOOL=qtconfig
   $ export QT_SELECT=4
   $ qtconfig

QT 的應用程式要用以上 2 個程式，修改主題為 GTK+，調整字型為自己喜歡的。

GTK theme
+++++++++

1. 安裝 lxappearance，用這個選擇要用的 gtk 主題。
2. 布景主題用 numix archblue。
3. 圖示主題用 faenza icon theme，這個看起來用的人挺多的。

   主題都改成扁平化設計，好看。
   ::

      $ yaourt -S lxappearance numix-themes-archblue faenza-icon-theme


4. google chrome 書籤列字型調整，原本的字實在太小。

   用 lxappearance 調整 gtk 2, 3 主題中的字型和大小。


xcursor icons
~~~~~~~~~~~~~

以 xmonad 為視窗管理器時，剛開機時會顯示一個 x 的游標。在 ``.xinitrc`` 加入::

   xsetroot -cursor_name left_ptr &

有時進入桌面後，會發現游標變成 X 預設醜醜的樣子，我還是喜歡 Oxgen Black 的游標主題。改回來！
參考：https://wiki.archlinux.org/index.php/Cursor_themes#Getting_mouse_cursor_themes

有三種做法：

1. 修改 ``/usr/share/icons/default/index.theme``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
::

   [icon theme]
   Inherits=Oxgen_Black

2. 也可以加個連結到 ``~/.icons/default``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
::

   $ ln -s /usr/share/icons/Oxgen_Black/ ~/.icons/default


3. 使用 ``lxqt-config-appearance``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

執行「LXQt 外觀設定」，它會直接產生 ``~/.icons/default/index.theme``。

**注意** 此程式會在 ~/.Xdefaults 中加入 Xcursor.theme=<them_name>

**建議用這個就好了，原因是方便。**


其它工具
========

lxqt-runner+lxqt-globalkeys
---------------------------

按下 Alt-F2 即可快速執行應用程式。
試用過 synapse、kupfer，還是決定用 runner 就好了。


pcmanfm-qt
----------

lxqt 預設的檔案管理器，目前可用了，但還是有些小問題，習慣它。
例如：滑鼠單擊執行程式的功能要先取消，否則在選擇多文件/檔案後，不好拖放。
::

   $ yaourt -S pcmanfm-qt gvfs-mtp

file-roller
-----------
安裝後，記得到 pcmanfm-qt 中設定預設的壓縮程式。
::

   $ yaourt -S file-roller


speedcrunch
-----------

很好用的計算器，就像寫數學公式，很親切的感覺。
::

   $ yaourt -S speedcrunch


結論
====

以前用 lxde 就覺得很不錯，也用了一整年。轉到 kde 是因為 htc 的關係。現在，我又回來用 lxqt，感覺很好。
只要能解決以下 3 個問題

1. mtp，解決與 htc 連線的需求。

   **解法** ：用 pcmanfm-qt + gvfs-mtp。

2. usb automount，這個應該不難。archlinux wiki 中有一些描述，可以試試。

   **解法** :doc:`udiskie-usb-storage-automount` 。

3. qbittorrent 中，能正確地開啟檔案所在目錄。現在是時有時無。

   **解法** 將 pcmanfm-qt 設為預設的檔案管理器
   ::

      $ xdg-mime query default inode/directory
      $ xdg-mime default pcmanfm-qt.desktop inode/directory


後記
====

非常滿足地用著 lxqt，感謝這個 team 的努力，讓我有個不錯的桌面可用。

在安裝 lxqt 的過程中，看到了一個看圖軟體 ``nomacs`` ，看起來不錯用，先記錄下來吧，免得忘了。
