.. title: 音樂檔案管理
.. slug: rip-cd-flow
.. date: 2014/05/22 15:06:00
.. tags:
.. link:
.. description:
.. type: text

rip cd 的流程
=============

自從決定回到 windows 下 rip cd 後，整個作業流程重新思考過，記錄如下：

EAC (Windows)
-------------

這個不用說，最令人放心的 cd ripper。

設定存檔目錄
~~~~~~~~~~~~
也不可去設定，那就是所有的檔案都會放在同一目錄下，下一個動作就重要了。

設定 cd 編號
~~~~~~~~~~~~
這個重要，只要不與其的 cd 重複，將來轉入 itunes 時就方便識別。

pacpl (Linux) --> 不用了
------------------------
自動將 wav 轉為 aiff。

執行 ``pacpl -t aiff *.wav`` ，將所有的 wav 轉成 aiff。

sox (Linux)
-----------
改用 sox 的原因很簡單，因為 pacpl 也是 call sox 而已。

kid3 (Linux)
------------
有 2 個原因讓我不得不用 kid3 來編 tags。

1. 用 itunes 編寫 tags，很慢。用 kid3 編 tags，真的快，而且可以只用鍵盤處理，不必動到滑鼠。

2. kid3 編出來的 aiff 檔，mpd 和 itunes 都可以用；如果直接以 itunes 編的 aiff tags，mpd 是讀不出 tags 的。

就這個原因，一定得用 kid3 囉。


puddletag (Linux)
-----------------
比 kid3 輸入更快的 tag editor

因為 kid3 目前有問題：輸入時編碼正確，存檔後會變成亂碼。
而且是顯示亂碼，用 itunes 和 puddletag 看存在檔案中的編碼，是正確的。

找了半天，找不出解法，只好另外尋找可用的 editor，於是才找這個更快的工具。

另外有一個好處，因此完全脫離了 KDE。


itunes (Windows)
----------------
轉入 itunes，由 itunes 管理，善用 itunes 的長處。

如有必要，將樂曲轉為 appleless 或 mp3，反正就是管理這些檔案。

這裡有個重點，現在的 itunes，在顯示曲風時，會用中文顯示。例如，jazz 顯示為「爵士樂」，真是多此一舉。
還好的是，在檔案中還是儲存為 jazz。

rsync (Linux)
-------------
將轉入 itunes 的音樂備份到 linux。

mpd (Linux)
-----------
回到 linux 後可以用 mpd 來聽音樂。


結論
====

如此的工作流程，是為了我的音樂轉入 ipod，itunes 不得不用。
其實 itunes 管理音樂也挺好的，只是要輸入 tag 很不方便，實在是不喜歡用滑鼠點來點去。

為了在 linux 下也有好聽的音樂，只能用 mpd。

如何將這 2 套系統結合，想出來的方法就是：用 windows 的 itunes 管理樂曲，用 linux 備份。

執行的動作再統整一下：

1. 先進 windows 執行 EAC
2. 重開機進 linux 執行 sox 和 kid3，轉檔和編 tag
3. 回 windows 執行 itunes 匯入檔案
4. 最後回到 linux 去備份處理完的檔案，用 mpd 聽音樂。

為了整理好這些音樂檔，要重開機 4 次，值得嗎？也許？會找到更好的方法。

雖然，看起來很麻煩，但時間上會比只用 itunes 處理要快得多。
因為，整個流程的瓶頸是在編寫 tags 上。itunes 真的不好用。如果有一天不用 windows、ipod，也許工作上會更順手。
