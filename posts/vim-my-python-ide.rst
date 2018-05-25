.. title: vim: my python IDE
.. slug: vim-my-python-ide
.. date: 2014/04/22 10:18:52
.. tags: vim, python
.. link:
.. description: computer
.. type: text

參考
=====

    `Turning vim into a modern python ide <http://sontek.net/blog/detail/turning-vim-into-a-modern-python-ide>`_


    用 vim 打造自己專屬的 python IDE。聽起來很累人，可是「男人要用男人自己的刀」，男人就是要用 vim。

Install
========
在裝 vim 前，先改 /etc/pacman.conf，加入
::

    [herecura-stable]
    Server = http://repo.herecura.be/herecura-stable/$arch


然後再裝這個 qt 版本。
::

    yaourt -Syua
    yaourt vim-gvim-qt


為何我裝這個 qt 版？因為我現在用的是 KDE。

python 摺疊
------------
``~/.vimrc`` 加上
::

    set foldmethod=indent
    set foldlevel=99

文法檢查與高亮
------------------
::

    sudo pip install pyflakes pep8


``~/.vimrc`` 加上

    let g:pyflakes_use_quickfix = 0
    let g:pep8_map='<leader>8'

補完
-----
::

    Bundle ''

註解
--------
::

    Bundle 'scrooloose/nerdcommenter'

    Usage
    The following key mappings are provided by default (there is also a menu provided that contains menu items corresponding to all the below mappings):

    Most of the following mappings are for normal/visual mode only. The |NERDComInsertComment| mapping is for insert mode only.

    [count]<leader>cc |NERDComComment|
    Comment out the current line or text selected in visual mode.

    [count]<leader>cn |NERDComNestedComment|
        Same as <leader>cc but forces nesting.
    ....\

    Toggles the comment state of the selected line(s). If the topmost selected line is commented, all selected lines are uncommented and vice versa.

    [count]<leader>cm |NERDComMinimalComment|
    Comments the given lines using only one set of multipart delimiters.

    [count]<leader>ci |NERDComInvertComment|
    Toggles the comment state of the selected line(s) individually.

    [count]<leader>cs |NERDComSexyComment|
    Comments out the selected lines ``sexily``

    [count]<leader>cy |NERDComYankComment|
    Same as <leader>cc except that the commented line(s) are yanked first.

    <leader>c$ |NERDComEOLComment|
    Comments the current line from the cursor to the end of line.

    <leader>cA |NERDComAppendComment|
    Adds comment delimiters to the end of line and goes into insert mode between them.

    |NERDComInsertComment|
    Adds comment delimiters at the current cursor position and inserts between. Disabled by default.

    <leader>ca |NERDComAltDelim|
    Switches to the alternative set of delimiters.

    [count]<leader>cl
    [count]<leader>cb |NERDComAlignedComment|
    Same as |NERDComComment| except that the delimiters are aligned down the left side (<leader>cl) or both sides (<leader>cb).

    取消註解
    [count]<leader>cu |NERDComUncommentLine|

整合 git
-----------------
``~/.vimrc`` 加上
::

    %{fugitive#statusline()}

檔案系統瀏覽器 file browser
---------------------------
::

    " NERDTree (better file browser) toggle
    map <F3> :NERDTreeToggle<CR>
