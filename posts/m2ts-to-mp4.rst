.. title: M2TS to mp4 via ffmpeg
.. slug: m2ts-to-mp4
.. date: 2015-05-04 07:33:03 UTC
.. tags: ffmpeg
.. category:
.. link:
.. description:
.. type: text


處理 Sony DV 拍出來的影片，還是用 ffmpeg。

split
=====

先將不要的片段切掉

.. code::

    ffmpeg -i a.m2ts -c copy -ss 1 -t 10 at.m2ts
    ffmpeg -i a.m2ts -c copy -ss 15 -t 20 bt.m2ts


convert M2TS to avi for concat
==============================

轉換成 avi 再 concat 的原因是，直接 concat M2TS 時，在交接的地方會很奇怪，
有一個 frame 會交錯，影片會跳一下。

.. code::

    ffmpeg -i at.m2ts -q 0 at.avi
    ffmpeg -i bt.m2ts -q 0 bt.avi

合併
====

將剛轉好的 avi 檔合併起來，至少有以下 2 種指令可用。

.. code::

    ffmpeg -i "concat:at.avi|bt.avi" -vpre ipod ab.mp4

或

.. code::

   cat [ab]t.avi | ffmpeg -i - -vpre ipod ab.mp4
