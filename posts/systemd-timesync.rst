.. title: 用 systemd-timesync 同步時間
.. slug: systemd-timesync
.. date: 2014-10-13 02:59:47 UTC
.. tags:
.. link:
.. description:
.. type: text
.. category: computer

先前用 ntpd，一直沒有成功對時。
昨日看到這個 systemd-timesyncd，那就試試看。一試就成，而且配置簡單。
我又不必設 ntp server，用這個同步時間就好了。

參考 https://wiki.archlinux.org/index.php/systemd-timesyncd

安裝
========

archlinux 中已經安裝好了，執行：
::

    $ sudo timedatectl set-ntp true
    $ sudo systemctl enable systemd-timesyncd.service
    $ sudo systemctl start systemd-timesyncd.service


配置
========

配置檔：/etc/systemd/timesyncd.conf
::

   [Time]
   NTP=tock.stdtime.gov.tw watch.stdtime.gov.tw time.stdtime.gov.tw clock.stdtime.gov.tw tick.stdtime.gov.tw
   FallbackNTP=0.pool.ntp.org 1.pool.ntp.org 0.tw.ntp.pool.org

其中，NTP server 用的是 `中華電信研究院國家時間與頻率標準實驗室 <http://www.stdtime.gov.tw/chinese/bulletin/NTP%20promo.txt>`_
的 server。

輕鬆完工。
