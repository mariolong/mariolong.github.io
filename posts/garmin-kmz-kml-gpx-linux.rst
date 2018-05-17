.. title: garmin kmz kml gpx linux
.. slug: garmin-kmz-kml-gpx-linux
.. date: 2014-12-10 03:00:40 UTC
.. tags:
.. link:
.. description:
.. type: text

買台了新的 Garmin u52，記錄我如何在 linux 中，將 google map 中的旅行規畫，上傳到這台 Garmin。


流程
====

下載 kmz
--------

google map 中進到「我的地圖」，將地圖上的景點下載成 kmz。

BaseCamp 是沒有辦法直接將 kmz 匯入後轉成 gpx，所以要另外想辦法。


kmz 轉成 kml
------------

其實 kmz 就是 kml 的壓縮檔。先改附加檔名為 zip，再解壓縮，找到 ``*.kml`` 檔，這個就是我們可以轉的檔。
::

   cp map.kmz map.zip
   7z x map.zip


kml 轉成 gpx
------------

先安裝 ``gpsbabel`` ，用下列指令轉檔。
::

   gpsbabel -i kml -o gpx map.kml

如此可轉出 ``map.gpx``

將 gpx 存到 Garmin 中
---------------------

最後，Garmin 以 USB 連上電腦，將剛轉好的 map.gpx 存到 GARMIN/GPX 目錄下, Garmin 重開機。
如此，航點就這樣轉進了 Garmin。

完工。

Garmin 更新地圖和軟體
=====================

要更新地圖或升級軟體，回到 Windows 下處理很方便。

進 myGarmin 官網，找到下載地圖和軟體的地方點下去，然後照著指示去做，
沒有難度。
