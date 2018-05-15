.. slug: autologin-without-dm
.. date: 2013/12/17 19:56:42
.. description:
.. link:
.. title: Autologin without DM
.. tags:

From here: https://bbs.archlinux.org/viewtopic.php?id=147913&p=3

and check the status on https://github.com/joukewitteveen/xlogin.git

Here are the installation steps, including for a systemd managed user dbus session instance.

1. Install xlogin-git from the AUR.
::

    yaourt -S xlogin-git

2. Create the following two files. 準備 D-BUS。

``/etc/systemd/user/dbus.socket`` containing:

.. code::

    [Unit]
    Description=D-Bus Message Bus Socket
    Before=sockets.target

    [Socket]
    ListenStream=/run/user/%U/dbus/user_bus_socket

    [Install]
    WantedBy=default.target

``/etc/systemd/user/dbus.service`` containing:

.. code::

    [Unit]
    Description=D-Bus Message Bus
    Requires=dbus.socket

    [Service]
    ExecStart=/usr/bin/dbus-daemon --session --address=systemd: --nofork --nopidfile --systemd-activation
    ExecReload=/usr/bin/dbus-send --print-reply --session --type=method_call --dest=org.freedesktop.DBus / org.freedesktop.DBus.ReloadConfig

3. Run (as root) ``systemctl --global enable dbus.socket`` .

4. Set up your .xinitrc and make sure it has the following near the top.

.. code::

    if [ -d /etc/X11/xinit/xinitrc.d ]; then
        for f in /etc/X11/xinit/xinitrc.d/*; do
            [ -x "$f" ] && . "$f"
        done
        unset f
    fi

Running your ``.xinitrc`` should not return,
so either have wait as the last command in your ``.xinitrc``,
or add ``exec`` to the last command that will be called and which should not return
(your window manager, for instance).

5. Include the following in your ``.bashrc`` .

.. code::

    for sd_cmd in systemctl systemd-analyze systemd-run; do
        alias $sd_cmd='DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/dbus/user_bus_socket" '$sd_cmd
    done

6. Run (as root) ``systemctl enable xlogin@<username>`` for automatic login at boot,
or ``systemctl start xlogin@<username>`` for launching a graphical user session (on tty7).

The user session lives entirely inside a systemd scope and everything in the user session should work just fine.

The above may look hard, but is not.

P.S.
The ``xorg-xinit`` package is not required for this method.
