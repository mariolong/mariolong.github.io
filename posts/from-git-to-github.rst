.. title: from git to github
.. slug: from-git-to-github
.. date: 2015-05-29 01:54:41 UTC
.. tags:
.. category: computer
.. link:
.. description:
.. type: text


想辦法把一些東西放到 github，一方面是可以備份，一方面可以分享。
當然，備份才是我的重點，順便分享給有需要的人。
畢竟從 open source 得到很多，也該把這個過程記錄下來，讓有需要的人採用。

安裝
====

`Github help <https://help.github.com/articles/set-up-git/>`_ 已經很寫得很清楚，重點是

git
git -global name
git -global email


問題
====

將已存在的專案 push 到 github
-----------------------------

1. 先在 github 建一個 repostory，例如：emacs.d

2. 回到 local 端，下指令 git remote add https://github.com/mariolong/emacs.d.git

#. git pull

#. touch .gitignore

#. git push -u origin master


push 失敗
---------
::

   $ git push -u origin master

   ! [rejected]        master -> master (non-fast-forward)
   error: failed to push some refs to 'https://github.com/mariolong/emacs.d.git'
   hint: Updates were rejected because a pushed branch tip is behind its remote
   hint: counterpart. Check out this branch and integrate the remote changes
   hint: (e.g. 'git pull ...') before pushing again.
   hint: See the 'Note about fast-forwards' in 'git push --help' for details.


   git checkout master
   git merge test
   git push -u origin master
