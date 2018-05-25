.. title: Using systemd to manage user session
.. slug: using-systemd-to-manage-user-session
.. date: 2016-10-08 08:36:16 UTC
.. tags:
.. category: computer
.. link:
.. description:
.. type: text


create /etc/systemd/system/user@.service.d/dbus_env.conf
::

   [Unit]
   Wants=dbus.service

   [Service]
   Environment=DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/%I/bus

show environment variables
::

   $ systemctl --user show-environment|grep DBUS
   DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus


create my_stuff.target
::

   [Unit]
   Description=My services
   Wants=dbus.service
   AllowIsolate=true

   [Install]
   Alias=default.target

enable it
::

   systemctl --user enable my_stuff_target

create ~/.config/systemd/user/alsa-tray.service
::

   [Unit]
   Description=show volume icon on systray

   [Service]
   Type=simple
   Environment=DISPLAY=:0
   ExecStart=/usr/bin/python2 /usr/bin/alsa-tray

   [Install]
   WantedBy=my_stuff.target

enable it::

  $ systemctl --user enable alsa-tray.service


reboot and success

參考文件
========

http://immae.eu/blog/2014/05/26/manage-your-session-with-systemd/
