.. title: emacs 教學指引
.. slug: emacsjiao-xue-zhi-yin
.. date: 2014/04/30 08:10:54
.. tags: emacs
.. link:
.. description:
.. type: text

程式寫多了，連個編輯器都想要折騰。

vim 和 emacs 並稱兩大神器。上星期玩了 vim 後，不知道為何，突然就想玩 emacs。好像是裝了 emacs 後，發現它的畫面比較好看，用起來比較有魅力吧？其實背後最主要的原因是 lisp。看了這麼多年程式碼，從沒用過像 lisp 或 haskell 這程語言寫過程式，初步看起來應該不會太難？那就來試試吧。

試了幾天，發現和 vim 比起來，Emacs 真的較不容易入門。上網找了半天，列出以下的參考資料：

`Sams Teach Yourself Emacs in 24 Hours <http://docs.huihoo.com/homepage/shredderyin/emacs24/index.htm>`_ 還有全書打包壓縮檔。

`某人筆記 <http://docs.huihoo.com/homepage/shredderyin/emacs_doc.html>`_

`Mastering EMACS <http://www.masteringemacs.org/>`_

`某人 wiki <http://lifegoo.pluskid.org/wiki/Emacs.html>`_ ，這裡可以連到很多資源，我不再表列囉。

`Seven habits of effective text editing <http://www.moolenaar.net/habits.html>`_

**Update (2014-5-14)**:搞了 2 個星期，用別人的配置，總是覺得怪。最後還是決定慢慢建立自己的配置檔。
其實這個也是 `magnars <https://github.com/magnars/.emacs.d/blob/master/README.md>`_ 的建議。
::

   emacs 配置檔就像自己的孩子，好好照顧他，陪他一起成長。

這一篇記錄的是可以在 emacs 中存活下來的最基本操作。
當然，按 C-h t 看 emacs 的教學也是一樣，只不過，我嫌它實在是寫得太囉嗦。

Install
============================================================
::

   $ yaourt emacs

基本操作
============================================================

表列最基本可以存活下來的指令：

C-x c-c
    離開 Emacs

C-g
    quit 放棄剛才的命令

移動游標
-----------------------------------------------------------------------
C-p 或 <up>
    游標上移一行

C-n 或 <down>
    游標下移下一行

C-f 或 <right>
    游標前進一個字元

C-b 或 <left>
    游標後退一個字元

M-f 或 <C-right>
    游標前進一個字，中文會前進到下一個標點位置上。

M-b 或 <C-left>
    游標後退一個字，中文會前進到上一個標點位置後.

M-a
    游標後退到句首

M-e
    游標前進到句尾

C-a 或 <home>
    游標退到行首（有字或含空白，可切換）

C-e 或 <end>
    游標前進到行尾

C-<home>
    到 buffer 頭

C-<end>
    到 buffer 尾

未知
    回到上一次游標位置

M-g M-g
    到指定的行號

捲動螢幕上的文字
-----------------------------------------------------------------------
C-l
    重畫螢幕。目前行會在視窗的中間、最上方、最下方三個地方切換。

C-v 或 PgDn
    下一頁

A-v 或 PgUp
    上一頁

C-PgDn
    向右捲動一頁

C-PgUp
    向左捲動一頁

視窗操作
-----------------------------------------------------------------------
C-x 0
    關閉目前視窗

C-x 1
    關閉其它視窗

C-x 2
    水平分割視窗

C-x 3
    垂直分割視窗

C-x o
    循環切換視窗

S-<方向鍵>
    切換焦點視窗 (要設定 windmove-default-keybindings)

C-x ^
    加高視窗

C-x {
    視窗變窄

C-x }
    加寬視窗

選擇區域 (mark region)
-----------------------------------------------------------------------
1. C-@
2. 移動游標

文字操作
-----------------------------------------------------------------------
backspace
    刪除前一個字元

C-x backspace
    很難理解。刪除到行首??刪除前面的空白

C-d
    刪除一個字元

A-backspace
    刪除到字首

A-d
    刪除到字尾

C-k
    刪除到行尾

C-w
    ？？刪除一行

M-<up>
    ？？整行或標示區上移

M-<down>
    ？？整行或標示區下移

C-o
    行為類似 <enter>，只是游標留在原行

C-_ 或 C-/
    undo

移動一下游標 C-/
    redo

copy, cut, paste
-----------------------------------------------------------------------

預設的區域是當行 (??)。如果沒有選擇區域，則會複製、剪下目前游標所在的那一行。

M-w 或 C-<ins>
    copy

C-w 或 S-<del>
    cut

C-y 或 S-<ins>
    yang (paste)

M-y
    yang-pop

檔案操作
-----------------------------------------------------------------------

C-x C-f
    find file，會優先找目前檔案所在的目錄

C-x C-v
    ??find alternate file

C-x C-s
    存檔

C-x s
    存檔，會詢問是否存檔

C-x C-w
    另存新檔

C-x i                   插入一個檔案

buffer
-----------------------------------------------------------------------
C-x k
    kill buffer

C-x b
    開啟 buffer

C-x C-b
    list buffer

C-x left/right
    切換 buffer

字型大小切換
----------------------------------------------------------------------
C-x C-0
    回復為預設大小

C-x C-=
    加大字型

C-x C--
    縮小字型
