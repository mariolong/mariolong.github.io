.. title: Show volume icon on systray
.. slug: show-volume-icon-on-systray
.. date: 2016-09-13 00:55:30 UTC
.. tags:
.. category:
.. link:
.. description:
.. type: text

試用了以下幾個可以在 linux systray 顯示音量 icon 的小程式：

- volti
- volicon
- volumeicon
- alsa-tray
- volwheel
- pnmixer

最後決定用 alsa-tray，原因是佔用的記憶體最少，而且操作模式不會很奇怪。

再寫個小小的 service，用 systemd 啟動就大功告成了。

::

   [Unit]
   Description=show volume icon on systray

   [Service]
   Type=simple

   ExecStart=/usr/bin/alsa-tray
   ExecReload=/bin/kill -HUP $MAINPID

   [Install]
   WantedBy=default.target
