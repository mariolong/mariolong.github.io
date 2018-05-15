.. title: Disable low-level screensaver and screen DPMS poweroff
.. description:
.. date: 2013/11/13 18:47:01
.. tags:
.. slug: disable-low-level-screensaver
.. link:

在 `Archbang wiki <http://wiki.archbang.org/index.php?title=ArchBang_Document>`_ 中看到一段話：

**Disable Blank Screen After 10 Minutes**

To disable blank screen after 10 minutes of inactivity,
create a file in /etc/X11/xorg.conf.d called custom.conf with this code:

快建立這個檔案試試。

.. code::

    ＄ nano  /etc/X11/xorg.conf.d/custom.conf

    Section "ServerFlags"
        # disable low-level screensaver and screen DPMS poweroff
        Option "BlankTime"  "0"
        Option "StandbyTime" "0"
        Option "SuspendTime" "0"
        Option "OffTime"  "0"
    EndSection

趕快記下來，試試看。
