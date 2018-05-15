.. title: generate mobi file by pandoc/kindlegen/calibre for my kindle 5
.. slug: generate-mobi-file-by-pandockindlegencalibre-for-my-kindle-5
.. date: 2014-11-14 02:55:28 UTC
.. tags:
.. link:
.. description:
.. type: text

買了 kindle 5 看電子書。

照慣例，思考著如何自動將網頁文章轉進我的電子書，讓我可以在閒暇時可以閱讀這些文章。

工具：
======

1. pandoc
2. kindlegen
3. calibre


流程：
======

pandoc 抓網頁資料



說明：
======

pandoc
------

kindlegen
---------

從 `官網 <http://www.amazon.com/gp/feature.html?docId=1000765211>`_ 下載後，直接解壓縮到一個目錄。

目錄下的 kindlegen 是可執行檔，所以建一個連結到我的 ``$PATH`` 中即可。

kindlegen 可以轉的檔案，我是選用 epub，也就是 pandoc 轉出來的那個檔。


傳到 kindle 上
--------------

USB
~~~

Transferring Using Dropbox
~~~~~~~~~~~~~~~~~~~~~~~~~~

http://google.about.com/od/kindlefire/a/How-To-Put-Non-Amazon-Books-On-Your-Kindle-Fire.htm

I usually don't like to fiddle with plugging my Kindle into my laptop,
so I use Dropbox to both store my library and transfer my eBooks to my devices.

If you use Dropbox, you'll want to navigate to your eBook file and rather than just tapping to open it,
you'll want to select the triangle to the right of the file name.

Next, tap Export.

Choose Save to SD Card (your Kindle doesn't actually have an SD card, but this gets you to the internal storage space).

Select either Books (for .mobi files) or Documents (for .pdf, .txt, .doc, and other files).
Tap Export.

Once you've done this, you should restart your Kindle Fire. Your books will appear after that.
If your book does not appear, double check that you waited for the book to fully copy to your Kindle's hard drive and
double check that you chose the correct folder for the file format.
