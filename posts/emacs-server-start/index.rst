.. title: emacs server start
.. slug: emacs-server-start
.. date: 2014/05/22 11:39:39
.. tags: emacs
.. link:
.. description: server-start can't use on my archlinux
.. type: text

很想用下面的指令開啟 emacs。但是以此法開啟 emacs 後，不是字型找不到，就是找不到 fcitx。
有時還真的想用 vim 算了，可以少掉很多的麻煩。
可是，看到 emacs 就有一股衝動，想用。
進了 vim 倒是沒有什麼用的動力，真是很奇怪的心情。
::

   emacs --daemon

======
 設定
======

在 init.el 中加上
::

   (unless (server-running-p) (server-start))

如果已開啟 server 模式，就不用再開一次。

現在的問題只剩下如何由 shell 中執行 emacs 指令。
可以用 id | sed 取出 uid，再看看 /tmp/emacs$uid/server 是否存在？
如果存在就用 ``emacsclient -t`` 開啟，否則就用 ``emacs``
::

   USERID=`id | sed 's/^.*uid=//g' | sed 's/(.*$//g'`
   echo $USERID
   ls /tmp/emacs$USERID/
   if test -e /tmp/emacs$USERID/server
   then
       echo "Server is already running."
       emacsclient -c "$@"
   else
       echo "Starting server."
       emacs "$@"
   fi
