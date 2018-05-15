.. title: archlinux enable cron
.. slug: archlinux-enable-cron
.. date: 2014/03/02 16:31:27
.. tags:
.. link:
.. description:
.. type: text


 <https://wiki.archlinux.org/index.php/cron>


Installation
=========================================================================

cronie is installed by default as part of the base group. Other cron implementations exist if preferred, Gentoo's cron guide offers comparisons. For example, fcron, bcron or vixie-cron are other alternatives. dcron used to be the default cron implementation in Arch Linux until May 2011.

Configuration
====================================================================

Activation and autostart

cron provided implementation cronie is not enabled by default in new Arch installs. This can be checked by looking at the log in /var/log/ or by issuing:

.. code::

   $ systemctl is-enabled cronie

Therefore, cronie systemd service must be started and enabled via systemctl prior or after setting the first cron job:

.. code::

   # systemctl start cronie
   # systemctl enable cronie

Default editor
========================================================================

To use an alternate default editor, define the EDITOR environment variablee it in a shell initialization script (vim-default-editor is available for vim users). For example:

.. code::

	# /etc/profile.d/nano-default-editor

加上：

.. code::

	#!/bin/sh
	export EDITOR=/usr/bin/nano

修改權限：

.. code::

	#chmod +x /etc/profile.d/nano-default-editor


Crontab format
=======================================================================

The basic format for a crontab is:
minute hour day_of_month month day_of_week command
minute values can be from 0 to 59.
hour values can be from 0 to 23.
day_of_month values can be from 1 to 31.
month values can be from 1 to 12.
day_of_week values can be from 0 to 6, with 0 denoting Sunday.
Multiple times may be specified with a comma, a range can be given with a hyphen, and the asterisk symbol is a wildcard character. Spaces are used to separate fields. For example, the line:
*0,*5 9-16 * 1-5,9-12 1-5 ~/bin/i_love_cron.sh
Will execute the script i_love_cron.sh at five minute intervals from 9 AM to 4:55 PM on weekdays except during the summer months (June, July, and August). More examples and advanced configuration techniques can be found below.

Basic commands
-----------------------------------------------

Crontabs should never be edited directly; instead, users should use the crontab program to work with their crontabs. To be granted access to this command, user must be a member of the users group (see the gpasswd command).
To view their crontabs, users should issue the command:
$ crontab -l
To edit their crontabs, they may use:
$ crontab -e
To remove their crontabs, they should use:
$ crontab -r
If a user has a saved crontab and would like to completely overwrite their old crontab, he or she should use:
$ crontab saved_crontab_filename
To overwrite a crontab from the command line (Wikipedia:stdin), use
$ crontab -
To edit somebody else's crontab, issue the following command as root:
# crontab -u username -e
This same format (appending -u username to a command) works for listing and deleting crontabs as well.

Examples
-----------------------------------------------------------

The entry::

	01 * * * * /bin/echo Hello, world!

runs the command /bin/echo Hello, world! on the first minute of every hour of every day of every month (i.e. at 12:01, 1:01, 2:01, etc.).
Similarly::

	*/5 * * jan mon-fri /bin/echo Hello, world!

runs the same job every five minutes on weekdays during the month of January (i.e. at 12:00, 12:05, 12:10, etc.).

The line (as noted in "man 5 crontab")::

    *0,*5 9-16 * 1-5,9-12 1-5 /home/user/bin/i_love_cron.sh
	0-35/5 9-16 * 1-5,9-12 1-5 /home/user/bin/i_love_cron.sh

will execute the script i_love_cron.sh at five minute intervals from 9 AM to 5 PM (excluding 5 PM itself) every weekday (Mon-Fri) of every month except during the summer (June, July, and August).
Periodical settings can also be entered as in this crontab template:
# Chronological table of program loadings
# Edit with "crontab" for proper functionality, "man 5 crontab" for formatting
# User: johndoe

# mm  hh  DD  MM  W /path/progam [--option]...  ( W = weekday: 0-6 [Sun=0] )
  21  01  *   *   * /usr/bin/systemctl hibernate
  @weekly           $HOME/.local/bin/trash-empty
