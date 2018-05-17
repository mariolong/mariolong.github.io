.. title: From XBMC to Kodi
.. slug: from-xbmc-to-kodi
.. date: 2015-10-29 03:51:27 UTC
.. tags:
.. category: linux
.. link:
.. description:
.. type: text

今天將客廳的 XBMC 升級至 Kodi，因為年代久遠，系統都沒有更新，發生了一些事情，還好都順利解決。
記錄下來，以利未來升級時參考。

連上網路
========
::

   $ sudo systemctl start adsl

更新系統
========
::

   $ yaourt -Syua --noconfirm

這步發生了 keyring out-of-date 的錯誤，更新系統失敗。
錯誤訊息類似：
::

   Import PGP key 4096R/. "email-address".........

修復錯誤的方法如下：
::

   $ yaourt -Sy archlinux-keyring
   $ yaourt -Syua --noconfirm


升級至 Kodi
===========

升級至 Kodi 時，因為系統中已經有 XBMC，會衝突。刪掉 XBMC 即可。
::

   $ yaourt -Rscn XBMC
   $ yaourt -S kodi kodi-standalone-service

安裝好，啟動 kodi.service，開機即可自動進入 Kodi，很方便。
::

   $ systemctl enable kodi


設定 Kodi
=========

中文字型
--------

進入了 kodi 後，我選用的是 reFocus 這個佈景主題，將介面語言改成中文。

這時操作錯誤，整個 Kodi 的字全部不見了。
還好對 Kodi 還算熟，按一按又救回來，否則只好砍掉重裝。

錯誤的原因是安裝佈景主題和選語言的順序錯誤，正確的順序：

1. 下載/安裝佈景主題。
#. 先選字型，改成 unicode。
#. 最後，選擇語言為 Chinese。

重點是，最後才能去選擇語言，不然就 GG 了。

音樂資料庫
----------

今天有重要的發現，原來 Kodi 的音樂資料庫是選擇目錄後，按 C 選「掃描至資料庫」，其實很方便。

她會分析檔案的 tag，甚至檔案中的插圖也可讀出，記錄到她的資料庫中。

以後，聽音樂就方便了。

設定時間
========

簡單設定就好了
::

   # timedatectl set-time "2014-05-26 11:13:54"

TODO:
=====

時間同步 ntp
------------

因為時間太久沒有調整，應該網路對時一下。

下次更新系統再做吧。
::

   # timedatectl set-ntp true

To check the service status, use timedatectl status::

  $ timedatectl status
