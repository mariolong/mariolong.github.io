.. title: Convert to pdf by pandoc
.. slug: convert-to-pdf-by-pandoc
.. date: 2015-11-26 02:14:13 UTC
.. tags:
.. category:
.. link:
.. description:
.. type: text

如何才能用 pandoc 輸出中文 pdf 檔？

安裝
====

首先要裝 texlive 和 cwTex 字型::

  $ yaourt -S texlive-most texlive-lang ttf-cwtex-q-fonts

配置
====

接下來設定 pandoc 中的 template，讓它可以使用正確的中文字。

執行
====

輸出時用下列指令：
::

   $ pandoc -o foo.tex foo.md --template=mytemp.tex


參考文件：
==========

archlinux wiki:

cwtex: https://github.com/l10n-tw/cwtex-q-fonts

用 pandoc 輸出 Markdown 文件：https://yenlungblog.wordpress.com/2012/10/26/pandoc/
