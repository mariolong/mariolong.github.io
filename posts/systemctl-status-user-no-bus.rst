.. title: systemctl status --user: Failed to connect to bus
.. slug: systemctl-status-user-no-bus
.. date: 2016-08-30 01:32:42 UTC
.. tags: systemd. linux
.. category: computer
.. link:
.. description:
.. type: text

最近在整理 systemd，玩著著就出包了。想看一下 service 的狀態，結果出來錯誤訊息：
::

   $ systemctl status --user
   Failed to connect to bus: No such file or directory

google 了半天，終於在 archlinux 的 `wiki
<https://bbs.archlinux.org/viewtopic.php?id=203647>`_ 中看到一句話：

::

   I had a systemd unit file for emacs as described in
   https://wiki.archlinux.org/index.php/Em … stemd_unit located in
   ~/.config/systemd/user/emacs.service When I removed it and rebooted
   the problem with startx and systemctl --user was gone.

想來是有寫不好的 user service，於是把還沒用到的 user service 隔離後，
問題立刻就迎刃而解啦。

記錄備查。
