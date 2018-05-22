.. title: linux 好好玩
.. tags: linux
.. category: computer
.. link:
.. slug: linuxhao-hao-wan
.. date: 2013/11/12 14:22:09
.. description:

為什麼要用 linux？ 剛開始是不想再被 windows 綁架，windows 慢啊。
用了之後發現，linux 真的很強大，工作的過程中，比較能掌握細節，每一次開機都覺得很有成就感。
而且，用命令列下指令，效率較高。
只是學習曲線比較陡峭，要花不少時間找資料。
還好，現在有 google 大神可以幫忙。

為什麼用 Archlinux？ 只是因為可以只安裝想要的東西，不必裝一堆用不到的功能。
如果選 ubuntu，那不如回去用 windows 就好了。
既然要學 linux，就學得深入點兒，搞清楚 linux 內部是如何運作的。

2013-5-13 update：從內核 3.6 開始用，到現在 3.9.2，只有一個感覺：快啊。
linux 的內核進步越來越快，用的資源反而變少了。
程式軟體執行的速度也越來越快，只有一個「爽」字可以形容。

安裝
========================================================================

我選用的是 Archlinux，安裝方式參看 :doc:`install-arch-linux` 。

目前選用的桌面是 :doc:`kde`。
剛開始玩 linux 時，用的是 lxde，後來用了 2 個星期的 Gnome 3，想用 digikam 就裝了 kde。
雖然 KDE 總會有一些惱人的小狀況發生，但還是比較喜歡這個桌面系統。最主要的原因有兩個：

* 各軟體的整合性比較好。
* 喜歡用的軟體大部份是 kde/qt。

試過 :doc:`tiling-window-manager-xmonad-with-kde` ，這個 twm 真的讓人覺得很快意，有機會的話，要把這 2 個整合起來。


常用軟體：
::

    $ yaourt -S ntfs-3g dosfstools gparted mpd mpdris2-git pacpl vlc ffmpeg aegisub google-chrome youtube-dl qbittorrent lftp imagemagick rsync qgit meld opencc python-pip nginx

    $ sudo pip install nikola requests webassets bottle uwsgi beaker

桌面
====

kde

lxqt+xmonad: 這是目前使用的組合


影音
========================================================================

audio
-------------------------------------------------------

音樂播放： :doc:`enable-mpd-with-systemd` ，linux 下唯一選擇 mpd。

cd ripper： :doc:`cd-ripper-rubyripper` 。不過已經放棄 linux 的 ripper，還是用 EAC。

pacpl：快速轉檔程式，通常用來將 wav 轉成 aiff。appleless 不適用，不過要轉 appleless 就用 itunes。

kid3：KDE 下編輯音樂檔 tags 的工具，這是目前用過最好用的，尤其是對 aiff 的支援，可同時適用於 itunes 和 mpd。

movies
-------------------------------------------------------

xbmc

vlc

ffmpeg: :doc:`ffmpeg-xin-de`

aegisub: 字幕編輯，我只用來把 srt 轉 ass，並設定字型和大小。

:doc:`dvd-backup`

生活記錄
========================================================================

digiKam: 同時管理照片和影片，號稱 linux 上最強大的照片管理軟體。

不過我現在不用這個龐大而笨重的軟體，改用 kdegraphics-gwenview 這個比較快速的 viewer，
搭配 dolphine 就很好用了。

**2014-4-5 update:** 真的放棄在 linux 中管理這些生活記錄，看看圖就好了，要管理、處理生活照片，還是回到 windows 下吧。
linux 只做備份工作，當然可以用 gwenview 和 dolphine 看看圖檔、照片。

phototnic: 有趣的看圖程式。

openshot: 製作影片的工具，簡單好用，但很容易無預警地結束程式，等待 V2 版。

imagemagick：好強的轉檔程式，可轉成 pdf。

lightwork: 強大的編輯影片工具。參看 :doc:`lightworks-on-archlinux` 。
還沒有做出作品來，整個工作流程看起來挺繁複的。


網路工具
========================================================================

wifi-ap: :doc:`archlinux-hostapd-netcfg`

lftp: :doc:`using-lftp-upload-website`

qBittorrent

youtube-dl： ``pip install youtube-dl``

google-chrome:
::

   google-chrome 的新可選依賴
   ttf-liberation: fix fonts for some PDFs

系統工具
========================================================================

lvm2: :doc:`LVM-on-archlinux`

gvfs + gvfs-mpt: 為了我的 HTC 手機，要裝這個，才好把照片、影片傳到電腦中處理。
在 KDE 中不必用這 2 隻程式，要用 kio-mtp。

ntfs-3g dosfstools gparted 磁碟有關的工具。

rsync: 超強大的備份工具。

systemd-timesyncd:

軟體開發工具
========================================================================

python

geany: :doc:`geany-xin-de`

kate: :doc:`kate-KDE-Advance-Text-Edit`

vim: 2014-4-20 終於決定開始進入 :doc:`vim` 的世界，看看這個號稱有史以來最好的文字編輯器，究竟好在什麼地方？

emacs: 2014-4-30 開始試用 emacs 之後，其它的文字編輯都不想用了，真是強到不知道如何形容，
基本操作記錄於 :doc:`emacsjiao-xue-zhi-yin` 。

git/qgit：版本管理

meld：視覺化本文差異分析

sqliteman: 用 kate 之後，這個就用不著了。因為 kate 有一個 sql 強悍的外掛。
emacs 中直接用 SQLi，什麼都可以用，就是介面醜了點，因為純命令列。

nginx: :doc:`an-zhuang-nginx`

bottle+uwsgi: :doc:`bottlenginx-with-uwsgi`

寫寫文章分享
========================================================================

寫些文章是做個記錄，記錄這一陣子的心得。

nikola
------
用 reStructureText 寫文章，將文章轉成靜態網頁的工具。
::

    yaourt -S python-pip
    sudo pip install nikola requests webassets bottle uwsgi beaker

上面安裝的 python 程式，主要是 nikola 和 stock 要用的 pyhton 程式庫。

Python
------
重新安裝全部的 python packages
::

   一 pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs sudo pip install -U

pandoc
-------------------------------------------------------
多種檔案格式互轉。我常用的是 html, epub, reSstructureText。主要的工作是將綱路上的文章轉到我的 greenbook 上閱讀。
::

    yaourt -S ghc alex happy cabal-install
    sudo cabal update
    sudo cabal install --global pandoc

opencc: 可以將簡體中文轉成繁體的工具。


小工具
------

kcalc: 小小計算機，可綁快捷鍵
::

   yaourt -S kdeutils-kcalc
