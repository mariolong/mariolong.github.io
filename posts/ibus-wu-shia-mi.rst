.. description:
.. title: IBus + 嘸蝦米
.. date: 2013/11/01 10:55:08
.. link:
.. slug: IBus-Boshiamy
.. tags:

安裝 ibus-table
::

    $ yaourt -S ibus-table

在 `liu_ibus_table.txt <http://francinelin.blogspot.tw/2012/07/ibus.html>`_ 可以加上常用的詞。然後執行
::

    $ sudo ibus-table-createdb -s liu_ibus_table.txt -n liu.db
    $ sudo cp liu.db /usr/share/ibus-table/tables/
    $ sudo cp liu.png /usr/share/ibus-table/icons/  # 這個好像沒用
    $ rm ~/.ibus/tables/liu-user.db     # 刪除 cache 中的檔案
    $ ibus restart      # 重啟 ibus

如果不行，請登出系統，重新登入，才能使剛才的修改生效。

好用的嘸蝦米就重出江湖了。

要學嘸蝦米，就要來 `這裡 <http://boshiamy.com/cai.html>`_ 。

fcitx還是比較好用，參考以下：

http://www.ubuntu-tw.org/modules/newbb/viewtopic.php?viewmode=compact&type=&topic_id=53570&forum=8

:doc:`ibusfcitxshu-ru-fa-she-ding`