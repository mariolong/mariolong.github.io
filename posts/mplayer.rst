.. title: mplayer
.. slug: mplayer
.. date: 2014-12-18 03:21:06 UTC
.. tags:
.. link:
.. description:
.. type: text
.. category: computer

我用的 wm 是 xmonad，想在每個螢幕上都能觀看同一部影片，故花了點時間研究 mplayer。

安裝
====
::

   $ yaourt -S mplayer

很可惜，我的顯示太舊，沒有支援 vaapi，否則就裝 mplayer-vaapi，用硬體加速囉。

配置
====

配置檔 ``~/.mplayer/config``
::

   # Set subtitle file encoding.
   unicode=yes
   utf8=yes

   # set the window size to 640*y
   xy=640

   # put the window to most right-bottom of screen
   geometry=-10-10

+ 字幕檔編碼都是 utf-8
+ 預設視窗大小 640，一開啟放在螢幕的右下角。


xmonad.hs
---------
::

   import XMonad.Actions.CopyWindow (copyToAll) -- useful for mplayer

   myManageHook :: ManageHook
   myManageHook = composeAll
       [ className =? "MPlayer" --> doFloatToAll
       , isFullscreen --> doFullFloat
       ]
     where
       doFloatToAll = doFloat <+> doF copyToAll -- floating window and copy it to all workspace


操作
====

只用鍵盤操作是我的目標，參考 https://wiki.archlinux.org/index.php/MPlayer

:q 或 <ESC>: 離開
:f: 全螢幕
:p 或 <SPC>: 播放/暫停
:<Left>/<right>: 前進/後退 10 秒
:<Up>/<Down>:  前進/後退 1 分鐘
:<PgUp>/<PgDn>:  前進/後退 10 分鐘
:o: 切換目前播放時間，總片長
:I: 顯示檔名
:j: 字幕切換
:#: 音軌切換
:m: 靜音切換
:9 或 /: 降低音量
:0 或 *: 增加音量

結語
====

現在，可以用 mc 執行影片檔，mc 呼叫 mplayer，自動在螢幕的右下角播放影片。
如果要移動視窗可以用 M + Button 1。

目前的配置符合我的需求，如有其它需求就再花點時間研究。

原本想用 vlc，但是配置 mplayer 比較快速、簡單，就先玩這個，有時間再來研究 vlc。
