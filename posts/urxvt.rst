.. slug: urxvt
.. link:
.. title: urxvt 使用心得與整理
.. tags: linux, urxvt, terminal, xmonad
.. category: computer
.. description:
.. date: 2014/05/27 10:45:30

為何要使用 urxvt？去年已經用 lilyterm 取代它了。
原因是：我現在用 kupfer 去快速呼叫程式，而這個的預設終端是 urxvt 和 terminator。
terminator 太過耗用資源，沒有必要用。
而且我現在用 xmonad，預設的 terminal 也是 urxvt，所以，改用 urxvt 吧！

urxvt 可以使用 daemon，這個可以試試看。

安裝
====
::

   $ yaourt -S urxvt compton

``compton`` 是為了真背景透明的效果。如果，只需要偽透明（像我用的是 xmonad，視窗不會重疊在一起），這個就不要裝。

配置
====

配置都放在 ``~/.Xresources`` 中。

透明背景
--------

wm 有支援透明的，用下列指令：
::

   URxvt.depth: 32
   URxvt.background: [90]#000000

或是用偽透明：
::

   ! 開啟透明
   URxvt.transparent: true
   ! 透明度 shading: 0 to 99 darkens, 101 to 200 lightens
   URxvt.shading: 10

字型
----

用我最愛的等寬字 ``Source Code Pro``
::

   URxvt.font:xft:Source Code Pro:size=16

配色
----

網上有一堆配色方案，直接套用。
::

   !MISC
   URxvt.colorBD:     #9B8AA8
   URxvt.colorIT:     #9B8AA8
   URxvt.colorUL:     #B29EB8
   !BLK
   URxvt.color0:      #404040
   URxvt.color8:      #767676
   !WHT
   URxvt.color7:      #D0D0D0
   URxvt.color15:     #FFFFFF
   !RED
   URxvt.color1:      #D0689D
   URxvt.color9:      #FFA0D5
   !GRN
   URxvt.color2:      #5E9A34
   URxvt.color10:     #95D16B
   !YEL
   URxvt.color3:      #AE8250
   URxvt.color11:     #E4B885
   !BLU
   URxvt.color4:      #698FC2
   URxvt.color12:     #9EC5F9
   !MAG
   URxvt.color5:      #B171DC
   URxvt.color13:     #E8A8FF
   !CYN
   URxvt.color6:      #2E9E6C
   URxvt.color14:     #6CD5A3


Daemon-Client setup through systemd
-----------------------------------
::

   /etc/systemd/system/urxvtd@.service

   [Unit]
   Description=RXVT-Unicode Daemon

   [Service]
   Type=oneshot
   RemainAfterExit=yes
   User=%i
   ExecStart=/usr/bin/urxvtd -q -f -o

   [Install]
   WantedBy=multi-user.target

Pass the username when starting the service:
::

   # systemctl enable urxvtd@username.service

開啟 daemon 後，以下列指令進 urxvt：
::

   urxvtc

問題
====

中文字距太大
------------

在 ``~/.Xresources`` 中加上
::

   URxvt.letterSpace: -1

如此一來，中英字距都會變小一點。
不過，設為 -1 就好，不然，整行字都會擠在一起，反而更難看。
這樣的設定後，看起來和 lilyterm 中看的感覺差不多。


中文輸入法 fcitx
----------------

竟然不能輸入中文？太奇怪了。只要在 ``~/.Xresources`` 中加上下列指令，中文輸入就不再是問題了。
::

   URxvt.inputMethod:fcitx


不能輸入中文
------------

如果同一個桌面上，開啟 2 個以上的終端，就不能輸入中文。天啊！真不知道如何處理。

**更新：如果將滑鼠指標移到命令列，點一點，就可以輸入中文了。**

也許是 lxqt 配合 xmonad 的問題吧？！目前應該不會有人去解決這個問題。
反正，有時不必動用到滑鼠，還是可以輸入中文，那就將就著吧。

後記
====

linux 真是個好玩的工具，只是要有足夠的時間、體力和興趣。用了一年之後，還是回來用這個 urxvt。


參考
====

1. `archlinux wiki: Xresources <https://wiki.archlinux.org/index.php/X_resources>`_
2. `archlinux wiki: urxvt <https://wiki.archlinux.org/index.php/rxvt-unicode>`_
3. `tomorrow night color theme <https://github.com/zezhyrule/dotfiles>`_
