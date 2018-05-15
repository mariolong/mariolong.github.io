.. title: rectange edit
.. slug: rectangle-edit
.. date: 2014-10-23 06:11:12 UTC
.. tags: emacs
.. link:
.. description:
.. type: text

emacs中有個矩形編輯功能。

以前在PE2時代就常用，到了windows時代後，就沒有用過，是因為windows的編輯器沒有提供這樣的功能，剛開始時還真的不習慣。
寫程式時，這是個很常用的功能。

功能鍵表列於下：

========= ========================================================
按鍵       說明
--------- --------------------------------------------------------
C-x SPC    啟動矩形編輯
C-x r k    kill-rectangle
C-x r t    replace-rectangle
C-x r y    yank-rectangle
C-x r N    rectangle-number-lines, 按C-u可輸入啟始數字。
C-x r y    yank-rectangle
C-x r d    delete-rectangle: 類似kill，只是不能 yank
C-x r c    clear-rectangle: 填入空白
C-x r o    open-rectangle: 插入空白，文字向右移
-          string-insert-rectangle
-          delete-whitespace-rectangle
-          delimit-columns-rectangle
========= ========================================================
