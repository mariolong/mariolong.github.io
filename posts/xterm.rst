.. title: xterm
.. slug: xterm
.. date: 2014-12-11 14:21:22 UTC
.. tags: xterm
.. link:
.. description:
.. type: text
.. category: computer

因為要用 synapse，又不知如何讓 urxvt 和 synapse 合作，所以裝上了 xterm。

用了之後，發現比起 urxvt，不僅速度快，而且佔用的記憶體也少得多，字體顯示也比較漂亮。

urxvt 會突然不能顯示的問題，也許就迎刃而解了吧？再觀察幾天看看。

參考 https://wiki.archlinux.org/index.php/Xterm

安裝
====
::

   $ yaourt -S xterm

就這個，沒別的。

配置
====

與 urxvt 一樣，xterm 的設定也放在 ~/.Xresource 中。

有了配置 urxvt 的經驗後，這次配置 xterm 就快得多了，幾乎都是用 urxvt 的設定。

256 色
------

不要設定環境變數 TERM，讓 xterm 去自動設定。不然 MC 會以為 term 不是 256 色的終端模擬器。
::

   XTerm*termName: xterm-256color

編碼改為 utf-8
--------------
::

   XTerm*locale: true
   XTerm*utf8Title: true

中英文字型
----------
安裝固定字寬和中文字型
::

   $ yaourt -S adobe-source-code-pro-fonts adobe-source-han-sans-otc-fonts

設定字型
::

   XTerm*faceName: Source Code Pro
   XTerm*faceNameDoublesize: xft:Source Hans Sans:style=Regular
   XTerm*faceSize: 16

透明背景
--------
~/.xinitrc 中加上
::

   compton &

在 ~/.bashrc 中加上
::

   [ -n "$XTERM_VERSION" ] && transset-df -a 0.97 >/dev/null

不捲動
------
有時要觀看輸出的內容，可是程式還是一直在執行，也一直在底部列印訊息。
這時就想要把資料停在目前觀看的範圍，不會隨著程式輸出，一直跳到輸出列。
::

   XTerm*scrollTtyOutput: false
   XTerm*scrollKey: true
