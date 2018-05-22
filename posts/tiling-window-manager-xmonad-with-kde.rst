.. date: 2013/12/02 09:10:51
.. slug: tiling-window-manager-xmonad-with-kde
.. title: Tiling window manager - Xmonad with KDE
.. tags: linux, xmonad, haskell
.. category: computer
.. description:
.. link:

update: 2014-10-15, 2014-4-29

為何沒事要來折騰這個玩意兒？實在是用過一下子的平鋪式視窗後，真的會著迷。
不過可用的 TWM 其實也不多，會選 xmonad 是因為 haskell，沒寫過這種程式，
就試看看吧，反正好玩好玩。

Installation
============

安裝的方法參看 :doc:`haskell-programs`

安裝好了，先看看 `官網上的教學 <http://xmonad.org/tour.html>`_ ，感覺
一下這個視窗管理員。


最重要的是進了桌面後，必須知道接下來要做的事，所以先看看有那些預設的熱
鍵。等到系統用熟了，再來考慮強大的自訂功能。

熱鍵
====

預設熱鍵
--------

先看預設的熱鍵，熟悉一下如何操作，想要改，等用熟了再說。man 一下就可以看到預設的熱鍵。
::

   $ man xmonad

其中有一段是說熱鍵，表列如下：

mod-shift-return
    呼叫終端機

mod-p
    [.] 呼叫 dmenu（預設是 mod-p，改成 mod-d）

mod-shift-p
    [x] Launch gmrun，不好用

mod-shift-c
    關閉目前焦點視窗

mod-space
    循環切換目前工作區的布局

mod-shift-space
    將目前工作區回復成預設的布局

mod-n
    [?] Resize viewed windows to the correct size

mod-tab or mod-j
    將焦點移到下一個視窗

mod-shift-tab or mod-k
    將焦點移到前一個視窗

mod-m
    將焦點移到主視窗（只移動焦點）

mod-return
    移動焦點視窗，放到主視窗的位置（是移動視窗）

mod-shift-j
    移動焦點視窗，到下一個視窗的位置

mod-shift-k
    移動焦點視窗，到上一個視窗的位置

mod-h
    向左/上變動視窗邊界（縮小主視窗）

mod-l
    向右/下變動視窗邊界（擴大主視窗）

mod-comma
    增加主視窗區的視窗數

mod-period
    減少主視窗區的視窗數

mod-t
    將視窗變回平鋪式

mod-[1..9]
    切換到第 N 個工作區

mod-shift-[1..9]
    將目前視窗移動到第 N 個工作區

mod-shift-q
    離開 xmonad

mod-q
    重啟 xmonad

mod-shift-slash
    Run xmessage with a summary of the default keybindings (useful for beginners)

mod+left button
    floating window

mod+right button
    resize floating window


自行定義的熱鍵
--------------

mod-<up>
    上一個非空的工作區

mod-<down>
    下一個非空的工作區

..
   mod-shift-x
       主視窗區左右交換顯示

   mod-shift-y
       主視窗上下交換顯示

配置
====

主要的工作是寫 ~/.xmonad/xmonad.hs，網上有一點點的配置檔可用。還是要研
究一下 haskell 的語法，比較好寫配置檔。

和 KDE 共舞
-----------

1. 設定成只有 1 個桌面 open the KDE Control Center, select Desktop >
   Multiple desktops, and set the number of desktops to 1.

2. 在 ~/.bashrc 中加上
::

   export KDEWM=/usr/bin/xmonad

3. 重開機，會進入以 xmonad 為 wm 的 KDE 環境。

雖然會有一點不習慣，但整個系統的整合性是好的。

獨立的工作環境
--------------

在 ~/.xinitrc 中加上
::

    exec xmonad

重開機即可執行 xmonad。因為它只是一個 wm，所以還是要找一些 trayer, dmenu 之類的程式一起，才能組成一個良好的工作環境。

寫 xmonad.hs
============

http://xmonad.org/xmonad-docs/xmonad-contrib/XMonad-Config-Desktop.html

kde1 <http://www.haskell.org/haskellwiki/Xmonad/Using_xmonad_in_KDE>

kde3 <https://github.com/shl/xmonad.hs/blob/master/xmonad.hs-KDE>

http://xmonad.org/manpage.html

放在 ~/.xmonad
::

   $ ln -sf kde3.hs xmonad.hs

取得 window 的 class name
-------------------------

1. terminal 執行 ``xprop``
2. 將十字游標移到要取得 class name 的視窗上，按下左鍵，即可得到 class name 和 title name

2.5 How do I uninstall xmonad?
==============================
If you have installed xmonad using your package manager, then just use it.
The following applies if you have built xmonad from source code (either darcs or stable release).
Let's assume you've installed xmonad to

the $PREFIX (that is, gave --prefix=$PREFIX argument to Setup.lhs configure). If unsure, try your

$HOME and /usr/local as $PREFIX.

rm  -f $PREFIX/bin/xmonad
rm -rf $HOME/.xmonad
rm -rf $PREFIX/lib/xmonad-$VERSION
# If you have installed XMonadContrib:
rm -rf $PREFIX/lib/xmonad-contrib-$VERSION

very cool configuration file for xmonad

http://www.linuxandlife.com/2011/11/how-to-configure-xmonad-arch-linux.html
