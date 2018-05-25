.. tags: rip CD, linux
.. title: CD ripper: rubyripper
.. link:
.. slug: cd-ripper-rubyripper
.. date: 2013/11/02 18:05:13
.. description:
.. category: computer

原本打算用 abcde rip CD。試 rip 了幾片，聽起來的聲音實在是差太多，真的受不了，只好再找合用的。
有人說，rubyripper 是除了 EAC 之外，最好的選擇，那就試試看吧。

.. TEASER_END: more

Install
========================================================================

::

    $ yaourt -S rubyripper-git

Setup
========================================================================

rubyripper 有 gtk2 圖形介面的 ``rrip_gui`` 和命令列式的 ``rrip_cli`` 。

以下是命令列的設定：

.. code::

	*** RUBYRIPPER SETTINGS ***

	** ENCODING **
	1)  flac [ ] , settings: --best -V
	2)  vorbis [ ] , settings: -q 4
	3)  mp3 [ ] , settings: -V 3 --id3v2-only
	4)  wav [*]
	5)  other [], settings:
	6)  playlist support [ ]
	7)  encode while ripping [1]

	** RIPPING **
	8)  cdrom : /dev/sr0 with offset 6
	   **Find your offset at http://www.accuraterip.com/driveoffsets.htm.
	   **Your drive model is shown in the logfile.
	9)  passing extra cdparanoia parameters : -Z
	10) match all chunks : 2
	11) match erroneous chunks : 10
	12) maximum trials : 80
	13) eject disc after ripping [*]

	** NAMING SCHEME **
	14) base directory : /home/mariolong/cd-rip
	15) standard scheme: %a (%y) %b/%n-%t
	16) various artist scheme: %f/%va (%y) %b/%n-%a-%t

	** FREEDB  **
	17) fetch cd info with freedb [*]
	18) always use first hit [*]
	19) site = http://freedb.freedb.org/~cddb/cddb.cgi
	20) username = anonymous
	21) hostname = my_secret.com

比較重要的是下面幾個參數：

``9)  passing extra cdparanoia parameters : -Z`` 不使用 cdparanoia 的糾錯，
把糾錯的工作完全交給 rubyripper。

``10) match all chunks : 2`` 告訴 rubyripper 先讀 2 次，比對有無不同。
當然可以設 3 以下，不過不會較好，只是多耗時間。

``11) match erroneous chunks : 10`` 當 rubyripper 發現不同，

``12) maximum trials : 80`` 最多重讀 80 次。

為何是如此設定？靈感來自 EAC。

和 EAC 比較
========================================================================

EAC 是目前公認最正確的 CD ripper。當然，以它為準，看 rubyripper 的結果是不是可以接受。

比較工具：

hexdump
    binary to text file.

meld
    compare two or three text files.

我的木耳
    呵呵，爽就好。


10、8-1、8-2、5、4 次得到的結果是不同的，那一個會比較好呢？不能確定。
但可以確定的是：8 次得到的結果和 EAC 的結果是一樣。
10 只有非常少的不同，100 bytes 以內。
結論是 rubyripper 可用。																																																																																											byripper 可用。

EAC 遇到讀取出錯時的策略：http://www.hksti.gov.cn/Ns.NewsView.Aspx?MBID=20&NewsID=6945&NewsClass=4

	EAC 會通過讀取每個 sector 兩次或者通過 C2 error information retrieval 來檢測讀取錯誤。

	如果檢測到錯誤的話，EAC 會反復讀取這個 audio sector 16 次。
	如果有 50% 次重讀返回的 sector 的數據是一樣的話，那麼這些樣本數據出錯的機會就很少了，
	EAC 將會使用這些樣本並繼續。

	如果 16 次重讀都沒有得到令人滿意的結果，EAC 將會開始另一系列的 16 次反復讀取。
	最多有 5 個系列的讀取動作，因此在 EAC 放棄讀取並顯示錯誤信息前最多有不超過 80 次的重讀。

註：(2013-12-11) rubyripper 怕沒人要維護了，還是回頭用 EAC 吧。

轉檔+tag
========================================================================

pacpl
------------------------------------------------------------------------
.. code::

	$ yaourt -S pacpl

	$ pacpl -t aiff *.wav

wav 轉成 aiff 檔，檔案內容和 itunes 轉成的 aiff 是一樣的。

不用 ffmpeg 轉的原因是：無論有沒有用 -c:a copy 這個參數，轉出來的內容和 itunes 轉出來的不一樣。

轉成 mp3

.. code::

	pacpl -t mp3 --bitrate 192 *.aiff


kid3
------------------------------------------------------------------------

不要用 kid3-qt。

用 kid3 可以編寫 aiff 的 tag，可以多檔同時編輯，方便的很。

.. code::

	$ yaourt -S kid3

最重要的是，itunes 和 mpd 均可讀出這 2 個程式處理過的 aiff 檔。

太棒了。

工作流程：
========================================================================

1. EAC rip CD。
#. 放到 mpd 的音樂目錄中。目錄結構為 /演唱(奏)者/專輯名稱/，方便 kid3 寫 tag 用。
#. pacpl 轉成 aiff 檔。
#. kid3 寫 tag。
#. rsync to windows for itunes
#. back to windows, import to itunes
