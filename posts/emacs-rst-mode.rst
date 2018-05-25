.. title: emacs reStructureText mode
.. slug: emacs-rst-mode
.. date: 2014/05/15 09:10:54
.. tags: emacs, rst, python
.. link:
.. description:
.. type: text
.. category: computer

參考 http://docutils.sourceforge.net/docs/user/emacs.html

=========
 install
=========

我用的是 emacs 24.3，預設已安裝 rst.el，檢查一下：
::

   M-x rst-mode


在 OS 中安裝 sphinx
::

   pip inistall sphinx

======
 配置
======

1. 客製化標題符號
#. …

==========
 操作指令
==========

指令分類
========

C-c C-a <up> or <down>
    切換標題層次
    改用 C-c C-= 切換

C-c C-c
    將目前檔案轉成 pdf 或 html 等目標檔

C-c C-l
    建立表列

C-c C-r
    處理目前的 region

C-c C-t
    處理目錄 (table of contents)

標題
====

C-c C-a C-a, C-c C-=, and C-=
    rst-adjust

    1. 如果所在行沒有標題符號，或不是完整的標題符號，則會建立標題符號，長度與本行文字等長，層次與上文中最近的一個標題相同。

    2. 已有完整的標題符號，則會循環升級標題層次。

    3. 可以先選定區域 (region)，區域內的標題可以一起切換。

C-- C-=
    降級標題

    可以先選定區域 (region)，區域內的標題可以一起切換。

客製化標題符號 (Customizations for Adornments)
----------------------------------------------

rst-preferred-adornments
    to a list of the adornments that you like to use for documents.

rst-default-indent
    can be set to the number of indent spaces preferred for the over-and-under adornment style.

C-c C-a C-d.
    rst-display-adornments-hierarchy

    顯示目前的標題符號表

C-c C-a C-s
    rst-straighten-adornments

    一次調整本文中所有的標題符號


C-M-a ??C-}
    rst-backward-section

    游標移至下一章節

C-M-e ??C-{
    rst-forward-section

    游標移至上一章節

C-M-h
    rst-mark-section

    選取整個章節

M-}
    游標移至下一段

M-{
    游標移至上一段

C-c C-r TAB
    rst-shift-region

    選取區域向右移動 1 個 TAB

M-- C-c C-r <Tab>
    選取區域向左移動 1 個 TAB

M-2 or M-- 2 C-c C-r <Tab>
    左移 2 個 Tab

M-0 C-c C-r <Tab>
    取消選取區域的所有縮排

M-x customize-group<RET> rst-indent<RET>
    設定縮排風格

Indenting Lines While Typing
    In Emacs the TAB key is often used for indenting the current line.
    rst-mode implements this for the sophisticated indentation rules of reStructuredText.
    Pressing TAB cycles through the possible tabs for the current line.
    In the same manner newline-and-indent (C-j) indents the new line properly.

C-j, <enter>, <Tab>
    針對當行，調整縮排

M-q
    fill-paragraph

    重排段落


轉檔
====

表列
====

If you have a couple of plain lines you want to turn into an enumerated list you can invoke

C-c C-l C-e
    rst-enumerate-region

    將一個選定的區域，轉成數字表列。

C-c C-l C-b
    rst-bullet-list-region

    轉成表列

C-u
    如果要將連續的文字行轉成（數字）表列，則可在執行命令前加上 ``C-u`` 。


rst-straighten-bullets-region (C-c C-l C-s),
    the existing bullets in the active region will be replaced to reflect their respective level.
    This does not make a difference in the document structure that reStructuredText defines,
    but looks better in,
    for example, if all of the top-level bullet items use the character -,
    and all of the 2nd level items use *, etc...



rst-insert-list (C-c C-l C-i)
    You may also invoke rst-insert-list at the end of a list item.
    In this case it inserts a new line containing the markup for the a list item on the same level.

區域
====

目錄
====
