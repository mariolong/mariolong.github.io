.. title: autojump
.. slug: autojump
.. date: 2014/04/22 09:06:38
.. tags:
.. link:
.. description:
.. type: text

這兩天開始用 vim，發現她真的是「神器」，喜歡雙手不用離開鍵盤的感覺。

所以，命令列的指令就用得多了，常在目錄間換來換去。今天在找資料時，不小心看到了這個小東西，原不在意，突然看到 github 上的「星星」，2000 多，嚇了一跳。那就裝上來用用吧。

Install
=======
::

    yaourt autojump-git

編輯 ~/.bashrc, 加入下列指令：
::

    #autojump
    [[ -s /etc/profile.d/autojump.bash ]] && . /etc/profile.d/autojump.bash

執行：
::

    . ~/.bashrc

即可享用 ``autojump`` 。

配置
====

參考 `github <http://github.com/joelthelion/autojump>`_ 上的說明。

這個小東西好像也不用配置吧。剛開始用的時候，怎麼只會留在目前目錄下，都跳不出去。man 一下，看到了這句話:

「autojump is a faster way to navigate your filesystem....  **Directories  must be visited first before they can be jumped to.**

這就是重點了，要先進去過一次，以後他就會記得。不過，用久了會不會我也不記得曾經進過那些目錄？

先用看看吧！

後記
====

會找到這個小工具，實在是因為想知道，如何在執行 bash shell 後，可以切換到另一個目錄。
方法很簡單：
::

    source xxx.sh

或是用
::

    . xxx.sh
