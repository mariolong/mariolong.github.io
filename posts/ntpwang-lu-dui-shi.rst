.. title: ntp 網路對時
.. slug: ntpwang-lu-dui-shi
.. date: 2014/03/09 08:25:28
.. tags:
.. link:
.. description:
.. type: text
.. category: computer

參考 https://wiki.archlinux.org/index.php/Network_Time_Protocol_daemon

安裝
======================================================

.. code::

    yaourt -S ntp

配置
======================================================

.. code::

    sudo nano /etc/ntp.conf

    # Associate to public NTP pool servers; see http://www.pool.ntp.org/
    server 0.pool.ntp.org iburst
    server 1.pool.ntp.org iburst
    server 2.pool.ntp.org iburst
    server 3.pool.ntp.org iburst

    # Only allow read-only access from localhost
    #restrict default noquery nopeer
    #restrict 127.0.0.1
    #restrict ::1

    # Location of drift file
    driftfile /var/lib/ntp/ntp.drift

Write a oneshot systemd unit:

.. code::

    sudo nano /etc/systemd/system/ntp-once.service

    [Unit]
    Description=Network Time Service (once)
    After=network.target nss-lookup.target

    [Service]
    Type=oneshot
    ExecStart=/usr/bin/ntpd -g -u ntp:ntp ; /usr/bin/hwclock -w

    [Install]
    WantedBy=multi-user.target


啟動
======================================================

.. code::

    sudo systemctl enable ntp-once

install
=============================================
::

    yaourt -S ntpd

archlinux 有預設值，可以直接啟動 ntpd。

Synchronize once per boot
=============================================

Warning: Using this method is discouraged on servers, and in general on machines that run without rebooting for more than a few days.

The ntp package provides the ``ntpdate.service``. Enable it with ``systemd`` to synchronize time once per boot.

This oneshot service is the useful option, if the system does not require the daemon to remain active after one successful time synchronization.

If the synchronized time should be written to the hardware clock as well, configure the provided unit as described in systemd#Editing provided unit files:
::

    /etc/systemd/system/ntpdate.service.d/hwclock.conf
    [Service]
    ExecStart=/usr/bin/hwclock -w

before starting it.

enable it
=============================================
::

    sudo systemctl enable ntpdate


error message
==============================================
::

    unable to bind to wildcard address 0.0.0.0 - another process may be running - EXITING

solution??