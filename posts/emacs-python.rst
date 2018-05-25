.. title: emacs python 環境設定
.. slug: emacs-python
.. date: 2014/05/24 12:10:54
.. tags: emacs, python
.. link:
.. description:
.. type: text
.. category: computer

平時是用 python 寫些程式，網路上很多將 emacs 配置成 python IDE 的文章。參考後，決定用 elpy，jedi 為後端。

安裝
====

elpy 的安裝分為 emacs 和 python 端。

emacs
::

   (require 'elpy)

python
::

   pip install elpy jedi

配置
====


問題記錄
========

版本不符
--------

elpy 報下列的錯誤訊息：
::

   You are not using the same version of Elpy in Emacs Lisp
   compared to Python. This can cause random problems. Please
   do make sure to use compatible versions.

   Elpy Emacs Lisp version: 1.4.1
   Elpy Python version....: 1.4.0


這個是 emacs 和 python 中的 elpy 版本不同所致，更新 python 中的版本即可。
::

   pip install --upgrade elpy
