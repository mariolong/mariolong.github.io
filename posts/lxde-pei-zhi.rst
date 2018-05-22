.. slug: lxde-pei-zhi
.. link:
.. title: lxde 配置
.. tags: linux
.. category: computer
.. description:
.. date: 2013/04/29 12:43:24


.. post_list:


Install LXDE
============================================================

用來用去，還是簡單點好，就用 lxde，把它搞好，也就夠用了。
::

    $ pacman -S lxde

登入 x 後，自動啟動 lxde。
::

    $ nano ~/.xinitrc

在最後加上
::

    exec startlxde

備忘一些 lxde 配置的方法

安裝 pcmanfm
===========================================================

::

    yaourt -S pcmanfm-git

terminal 改成 lilyterm
-----------------------------------------------------------

參考 `lilyterm 使用心得與整理 <./lilyterm.html>`_


在特定的桌面 (Desktop) 開啟應用程式
===========================================================

確認應用程式的 name
------------------------------

Run `obxprop | grep "^_OB_APP"` to see the value of these five properties.
The output will look like::

 _OB_APP_TYPE(UTF8_STRING) = "normal"
 _OB_APP_CLASS(UTF8_STRING) = "Google-chrome"
 _OB_APP_NAME(UTF8_STRING) = "google-chrome"
 _OB_APP_ROLE(UTF8_STRING) =
 _OB_APP_TITLE(UTF8_STRING) = "Google Chrome"

You have to specify at least one of class and name.

編輯 `~/.config/openbox/lxde-rc.xml`
----------------------------------------

::

 <applications>

      <application name="lxterminal">
        <desktop>5</desktop>
        <maximized>no</maximized>
        <focus>yes</focus>
      </application>

 </applications>

編輯 `~/.config/lxsession/LXDE/autostart`
------------------------------------------------

加上要執行的應用程式::

    pcmanfm -d      # 以 daemon mode 開啓 pcmanfm
    @fcitx

在重啟 lxde(openbox) 後，即可看到效果。
