.. title: zsh
.. slug: zsh
.. date: 2014-10-28 07:50:23 UTC
.. tags: Linux
.. link:
.. description:
.. type: text


install
=======




plugin
======

history-substring-search
------------------------
直接加入 plugins 中。

zsh-syntax-highlighting
-----------------------

來源：https://github.com/zsh-users/zsh-syntax-highlighting

::

   $ yaourt -S zsh-syntax-highlighting-git

在 .zshrc 中加入下列一行：
::

   plugins=(... zsh-syntax-highlighting)
