.. title: 字型相關
.. slug: fonts
.. date: 2015-05-27 13:48:41 UTC
.. tags: linux, font
.. category: computer
.. link:
.. description:
.. type: text

**己經没有 [infinality-bundle] 了，這篇留作紀念。**

系統看起來要好看，最重要的其實是字型，字型沒調好看起來就是怪怪的，不舒服。

目前我的解法是參考 https://wiki.archlinux.org/index.php/Infinality 設定整個系統的字型。

安裝
====

1. 增加公鑰
::

   $ sudo pacman-key -r 962DDE58
   $ sudo pacman-key --lsign-key 962DDE58


2. 編輯 ``/etc/pacman.conf`` ，加上
::

   [infinality-bundle]
   Server = http://bohoomil.com/repo/$arch


3. 更新資料庫，並安裝 ``infinality-bundle``
::

   $ yaourt -Syy
   $ yaourt -S infinality-bundle


4. 安裝字體，可以挑選 `這裡 <http://bohoomil.com/doc/05-fonts/>`_ 有的。

   例如，想用 ``adobe-source-code-pro-fonts`` ，查到有 ttf-source-code-pro-ibx，
   那就可以安裝。
   ::

      $ yaourt -S adobe-source-code-pro-fonts

   目前我安裝的是以下字型：
   ::

      $ yaourt -S ttf-tw ttf-dejavu ttf-oxygen ttf-liberation
      $ yaourt -S adobe-source-han-sans-otc-fonts adobe-source-sans-pro-fonts adobe-source-serif-pro-fonts adobe-source-code-pro-fonts

#. 用 lxqt-config-apperance 調整字體渲染方式。

   自動產生 ``~/.config/fontconfig/fonts.conf`` 和 ``~/.config/fonts.conf`` 一樣的檔案。

#. 微調 ``/etc/X11/xinit/xinitrc.d/infinality-settings.sh``

   設定 USE_STYLE="3"

#. 重啟 X 看結果。

結論
====

暫時就先這樣，有空再來調整吧。