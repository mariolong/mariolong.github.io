.. date: 2013/10/25 08:16:10
.. description:
.. tags: dvd, backup
.. category: computer
.. title: DVD backup
.. link:
.. slug: dvd-backup

手邊一堆 DVD，不保存到電腦裡，不安心啦。
為了保存這些 DVD，大約的流程如下：

#. 先將 DVD 轉成 ISO。
#. 把 ISO 裡的 VIDEO 目錄抓出來。
#. VIDEO 中的 \*.VOB 轉成 \*.mkv 保存。
#. 有必要時，可以將 mkv 轉成自己想要的格式。

DVD to ISO
--------------------------------------------------------------------

爲了保存有價值的影片，儘量用比較高品質的壓縮方法。

參考 `BACKING UP DISNEY DVDS <http://www.cmdln.org/2010/01/22/backing-up-disney-dvds/>`_

需要安裝的軟體：
::

    $ yaourt -S ddrescue dvdbackup libdvdcss

使用流程：
::

    ddrescue -n -b 2048 /dev/cdrom dvd.iso
    dvdbackup -M -i dvd.iso -o dvd-dir

如此就把整片 DVD 備份到 dvd-dir 中了。
接下來，再針對 dvd-dir 中的影片處理。

DVD to MKV
---------------------------------------------------

參考 `ffmpeg-xin-de`

先將 ISO 轉成 MKV ::

    cat VTS_01_[1234].VOB | ffmpeg -probesize 214748000 -analyzeduration 214748000 -i - \
    -map 0:0 -map 0:1 -map 0:2 \
    -crf 18 -preset veryslow -tune help\
    -filter:v yadif \
    -c:a copy -c:s copy -y a.mkv

#. ``-probesize 214748000 -analyzeduration 214748000`` 有時會因爲音軌或字幕軌太晚出現，ffmpeg 會偵測不到，這時就加長偵測的時間和大小。

#. ``-map 0:0 -map 0:1 -map 0:2`` 是要封裝到 mkv 的軌道。

#. ``-crf 18 -preset veryslow`` 用這個參數大概就好了，眼睛看不出來與原始有何差異。有必要時可以再加上 -tune。

#. ``-filter:v yadif`` 就是 deinterlace。

#. ``-c:a copy -c:s copy`` 音軌和字幕軌都不重新編碼。

如果沒有字幕，可以先取得字幕檔，再保存到 mkv 中，如下：
::

    $ cat VTS_01_[1234].VOB | ffmpeg -i - -i a.ssa \
    -map 0:0 -map 0:2 -map 1 \
    -crf 18 -preset veryslow -tune zerolatency \
    -filter:v yadif \
    -c:a copy -c:s copy \
    -y a.mkv

重點是 ``-i a.ssa -map 1 -c:s copy``


color of dvd subtitle
---------------------

https://en.wikibooks.org/wiki/FFMPEG_An_Intermediate_Guide/subtitle_options

$ ffmpeg -palette "551A8B,551A8B,ffffff,000000,ffffff,ffffff,ffffff,ffffff,ffffff,ffffff,ffffff,ffffff,ffffff,ffffff,ffffff,ffffff" -i candy-001.mkv -c:a copy -filter_complex "[0:v][0:s]overlay" a.mkv

1. 字框
2. 外框
3. 不知
4. 字本身
