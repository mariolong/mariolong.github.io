.. title: imagemagick
.. slug: imagemagick
.. date: 2014-12-05 06:05:31 UTC
.. tags: linux, imagemagick, pdf
.. link:
.. description:
.. type: text
.. category: computer

用了好一陣子的 imagemagick，真的覺的很不錯，記錄一些指令備忘

安裝
====
::

   yaourt -S imagemagick ghostscript


其中 ghostscript 可處理 pdf 檔

指令
====


去背
----
::

   convert in.gif -transparent white -white-threshold 95% out.png

``-transparent white`` 是將白色當成背景而去掉。但有時背景不夠白，就加上 ``-white-threshold 95%`` 這段。


pdf to jpg/png
--------------
::

   convert -density 600 p.pdf p-%2d.jpg
   convert -density 600 p.pdf -resize 25% p-%2d.png