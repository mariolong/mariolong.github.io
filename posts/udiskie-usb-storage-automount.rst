.. title: udiskie: usb storage automount
.. slug: udiskie-usb-storage-automount
.. date: 2014-10-23 13:48:57 UTC
.. tags: linux, lxqt, desktop
.. category: computer
.. link:
.. description:
.. type: text

這陣子用了一些方便想自動掛載「移動裝置」，最後決定用 udiskie，小小地記錄下來，備查。

**upadte** 2014-10-24: 用 lxqt-panel + removable meida/device manager plugin + libfm，即可自動掛載。
一定要裝 libfm 才能在 removable media/devices meanger 中看到 usb 移動裝置。

它會使用 udisk2 執行掛載，應該是配合 KF5 吧。

lxqt 愈來愈好用了，真是名符其實的「台灣之光」，加油。


安裝
====
::

   $ sudo pip install udiskie
   $ yaourt -S python-gobject libfm


執行
====
::

   $ udiskie &

測試 OK，可以放進 .xinitrc

結論
====

最後決定的方式是：在 lxqt-panel 上加上 removable media/devices manager 外掛，
讓 panel 可以顯示是否有移動裝置插入 usb。
如果要卸載，也是使用這個外掛，按一下即可。

如果有移動裝置插入 usb 時，要自動掛載。
則可在 ~/.xinitrc 中加上 ``udiskie &`` 讓它在背景執行。

如此就方便了，可以自動掛載，也可以手自動卸載。
