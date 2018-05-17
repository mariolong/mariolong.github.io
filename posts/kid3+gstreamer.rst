.. title: kid3+gstreamer
.. slug: kid3+gstreamer
.. date: 2015-11-17 04:40:21 UTC
.. tags:
.. category:
.. link:
.. description:
.. type: text

想用 kid3 來編音樂檔的 tag，在編的時候也要聽一聽這個檔的內容。預設安裝的 kid3 一直沒有辦法聽，錯誤訊息是類似
::

   gstreamer plugin not found audio/x-aiff


我想這個問題不大嘛，加裝外掛就好。沒想到裝了也沒用。

今天終於發現，我的系統中裝了 gstreamer0.10，我以為是這個，所以只去安裝它的外掛。
當 kid3 發不出聲音的時候，還真的很奇怪。

原來 gstreamer0.10 是 aegisub 的依賴，我的系統中只有這隻程式會用到。真是無言。

kid3 用的是 gstreamer，要加裝它的外掛，我的選擇是全裝：
::

   $ yaourt -S gstreamer gst-plugins-base gst-plugins-good gst-plugins-bad gst-plugins-ugly gst-libav

這回真的成功發出聲音，又可以用 kid3 囉！
