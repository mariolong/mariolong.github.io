.. description:
.. date: 2013/11/01 18:50:21
.. slug: ibusfcitxshu-ru-fa-she-ding
.. tags:
.. link:
.. title: ibus,fcitx輸入法設定

ibus
========================================================================

GNOME 3.10 中，IBus 是整合在一起，裝了 GNOME，IBus 就安裝好。
剩下的只是安裝自己要的輸入法。
::

    $ yaourt -S ibus-rime ibus-chewing

IBus的字形大小，預設的太小，參考 :doc:`gnomean-zhuang-ji-lu` 修改。

[2013-11-1] 拼音的 rime 實在不是我的最愛，自動選字，常常不是我想要的，現在還是回到「嘸蝦米」。
參考 :doc:`IBus-Boshiamy` 。

fcitx 【中州韻】和【新酷音】
========================================================================

在 LXDE 中，ibus 和 google-chrome 衝突，暫時先切到 `fcitx
<https://wiki.archlinux.org/index.php/Fcitx>`_ 。

[2013-11-01] 用 GNOME 3.10，IBus 和 google-chrome 配合良好。

至少到目前爲止，fcitx 和我的系統 (LXDE) 配合度很良好。
在 Archlinux 中 `fcitx-rime <https://www.archlinux.org/packages/community/i686/fcitx-rime/>`_
看來也有人維護，那就繼續用吧。

安裝【中州韻】和【新酷音】：
-------------------------------------------------------------------
::

    $ yaourt -S fcitx fcitx-rime fcitx-chewing fcitx-configtool fcitx-gtk{2,3} fcitx-qt

不必用 fcitx-rime-git。

配置
--------------------------------------------------------------------

在 `~/.xinitrc` 增加一行：
::

    fcitx &

在 `~/.bashrc` 加上：
::

    export GTK_IM_MODULE=fcitx
    export QT_IM_MODULE=fcitx
    export XMODIFIERS="@im=fcitx"

fcitx 的嘸蝦米
=======================================================================

fcitx
還是比較好用，使用說明參考 `(推薦)在fcitx輸入法下，(boshiamy)嘸蝦米的使用最為順暢、穩定!（新酷音、m17n、倉頡、輕鬆法亦適用） <http://www.ubuntu-tw.org/modules/newbb/viewtopic.php?viewmode=compact&type=&topic_id=53570&forum=8>`_ 。

KDE 安裝 fcitx + 嘸蝦米 + 酷音
-------------------------------------------------------------
::

    yaourt -S fcitx-im fcitx-table-extra fcitx-chewing kdeplasma-addons-applets-kimpanel kcm-fcitx fcitx-qt5

配置
--------------------------------------------------------------------

在 `~/.xinitrc` 增加一行：
::

    fcitx &

在 `~/.bashrc` 加上：
::

    export GTK_IM_MODULE=fcitx
    export QT_IM_MODULE=fcitx
    export XMODIFIERS="@im=fcitx"

自行加詞
--------------------------------------------------------------

參考： `(推薦)在fcitx下的好用自製碼表工具，mb2txt與txt2mb（嘸蝦篇）
<http://www.ubuntu-tw.org/modules/newbb/viewtopic.php?topic_id=58540&forum=22&
post_id=257328#forumpost257328>`_

命令：
::

    cd ~/.config/fcitx/table
    mb2txt boshiamy.mb > boshiamy.txt

編輯 boshiamy.txt，加上想要的詞。編好後，轉成嘸蝦米的碼表：
::

    txt2mb boshiamy.txt boshiamy.mb

在中文的輸入環境下，切換到嘸蝦米，按 Ctrl+5，以讀取新表，即可使用新定義的詞。
