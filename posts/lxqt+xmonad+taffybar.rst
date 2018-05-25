.. title: 我的桌面組合 lxqt+xmonad+taffybar
.. slug: lxqt+xmonad+taffybar
.. date: 2014-12-10 06:24:15 UTC
.. tags:
.. link:
.. description:
.. type: text
.. category: computer

目前選擇的桌面是 lxqt，取其輕快美。嗯，相對於 lxde 是漂亮多了。

視窗管理用 xmonad，可全時鍵盤操作，配置自由度非常高。

panel 用的是 taffybar，原因是 lxqt-panel 的 workspace-switcher 和
xmonad 配合有問題，不得不研究一個可用的 panel。配置好了這個 panel 後，即
使後來 lxqt-panel 修復，也不想再換回 lxqt-panel。

呃，有點孤芳自賞，或說是敝帚自珍吧。

安裝
====

安裝、配置 lxqt
---------------

參看 :doc:`lxqt`

安裝 xmonad::
-------------

  $ cabal install xmonad xmonad-contrib taffybar


配置
====

lxqt
----

參看 :doc:`lxqt`

xmonad
------

  DoAndShift
  google-chrome
  FullFloat
  xterm

taffybar
--------

  theme
  clock
  calendar
  network
  appLauncher
  workspaceSwitcher
  :doc:`show-volume-icon-on-systray`