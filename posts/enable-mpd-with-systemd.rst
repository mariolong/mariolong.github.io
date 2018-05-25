.. title: enable mpd with systemd
.. date: 2013/11/26 14:17:33
.. description:
.. tags: linux, mpd, music
.. slug: enable-mpd-with-systemd
.. link:
.. category: computer

error message:

.. code::

    $ systemctl --user status mpd.service
    Failed to issue method call: Process /bin/false exited with status 1

    $ sudo journalctl -u mpd
    fatal_error: Can't create db file in "/var/lib/mpd": Permission denied

參考：https://wiki.archlinux.org/index.php/Systemd/User#Setup_since_systemd_206 後，
解決了這個問題。

下這個指令：

.. code::

    # sed -i s/system-auth/system-login/g /etc/pam.d/systemd-user

2014-3-14 update：現在不必用上述的方法囉。

加環境變數的檔：

.. code::

    # EDIT /etc/systemd/system/user@.service.d/environment.conf
    [Service]
    Environment=DISPLAY=:0

**2014-4-3 update** : 為何這個 install 標題在這個位置？因為以上都是過去的故事了。
還是把它留著，免得下次又重做這些不必要做的事。

install
========================================================================

::

    yaourt -S mpd ncmpcpp mpdris2-git cantata cdparanoia

配置
========================================================================

::

    nano ~/.config/systemd/user/mpd.service

內容如下：

.. code::

    [Unit]
    Description=Music Player Daemon

    [Service]
    Nice=-10
    ExecStart=/usr/bin/mpd --no-daemon /home/mario/.mpdconf
    ExecStop=/usr/bin/mpd --kill

    [Install]
    WantedBy=default.target

把 mpd 開起來吧，不必 reboot！

.. code::

    $ systemctl --user start mpd
    $ systemctl --user enable mpd

在 KDE 中使用 mpd-client，比較好用的 ncmpcpp 和 cantata。

ncmpcpp 配置起來也是「落落長」的故事。

cantata 設定
=========================================================================

cantata 要連上 mpd 其實也沒有什麼設定，只要把 config cantata > collection > Music folder 的值設為 mpd 的設定檔位置即可：例如我的是 ``/home/mario/.mpd``。

如此 cantata 就自動連上 mpd，可以操控 mpd 的播放。

config cantata > playback > playback stop on exit 要取消掉，不然關了 cantata 就沒音樂了。
