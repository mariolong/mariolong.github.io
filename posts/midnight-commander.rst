.. title: Midnight Commander
.. slug: midnight-commander
.. date: 2014-12-17 06:23:00 UTC
.. tags: mc, linux
.. category: computer
.. link:
.. description:
.. type: text


安裝
====
::

   $ yaourt -S mc

配置
====

編輯 ``~/.config/mc/mc.ext`` 或 <F9> -> Command -> 編緝擴充檔，調出配置檔。
然後，在此檔中找相對應的副檔名，做些修改。

epub viewer
-----------

用 python 寫個小程式，可以顯示 epub 的內容。
::

   # Epub
   shell/i/.epub
       Open=/usr/lib/mc/ext.d/doc.sh open epub
       # View=%view{ascii} /usr/lib/mc/ext.d/doc.sh view epub
       View=%view{ascii} /usr/bin/python /mnt/lvm-data/Programing/epub/epubinfo.py %f


以 mpv 開啟影像檔
---------------------
::

   include/video
       Open=(mpv %f >/dev/null 2>&1 &)   # for mpv

鍵盤操作
========

mc 的鍵盤操作，有點類似 emacs。

Ctrl-g
    中斷目前作業，如果有作業花了太久的時間，按下 C-g 吧。

Miscellaneous Keys
------------------

類似 lynx 的方向鍵用法，很好用。要先去 Options > panel options 中設定

:left: 回到上一層目錄

:right,return: 進目錄或開檔

:Enter: if there is some text in the command line (the one at the bottom of the panels), then that command is executed.
        If there is no text in the command line then if the selection bar is over a directory
        the Midnight Commander does a chdir(2) to the selected directory and reloads the information on the panel;
        if the selection is an executable file then it is executed.
        Finally, if the extension of the selected file name matches one of the extensions in the extensions file
        then the corresponding command is executed.

:C-l: 重畫 MC

:C-x c: run the ``Chmod`` command on a file or on the tagged files.

:C-x o: run the ``Chown`` command on the current file or on the tagged files.

:C-x l: run the link command.

:C-x s: run the symbolic link command.

:C-x i: set the other panel display mode to information.

:C-x q: set the other panel display mode to quick view.

:C-x !: execute the External panelize command.

:C-x h: run the add directory to hotlist command.

:Alt-!: executes the Filtered view command, described in the view command.

:Alt-?: executes the Find file command.

:Alt-c: 快速切換目錄。必須知道完整的目錄名稱，實務上可能並不好用。

:C-o: when the program is being run in the linux or FreeBSD console or under an xterm, it will show you the output of the previous command. When ran on the linux console, the Midnight Commander uses an external program (cons.saver) to handle saving and restoring of information on the screen.
      When the subshell support is compiled in, you can type C-o at any time and you will be taken back to the Midnight Commander main screen, to return to your application just type C-o. If you have an application suspended by using this trick, you won't be able to execute other programs from the Midnight Commander until you terminate the suspended application.

directory panels
----------------

:Tab, C-i: 切換 panel

:Insert, C-t: to tag files you may use the Insert key (the kich1 terminfo sequence). To untag files, just retag a tagged file.

:M-e: 選擇編碼

:Alt-g, Alt-r, Alt-j: used to select the top file in a panel, the middle file and the bottom one, respectively.

:C-s, Alt-s: 尋找目前目錄下的檔案。可連續按 C-s 連續尋找。

:Alt-t: 切換表列模式。

:C-\: 書籤

:+: (plus) this is used to select (tag) a group of files.
    The Midnight Commander will prompt for a selection options.
    When Files only checkbox is on, only files will be selected.
    If Files only is off, as files as directories will be selected.
    When Shell Patterns checkbox is on, the regular expression is much like the filename globbing
    in the shell (* standing for zero or more characters and ? standing for one character).
    If Shell Patterns is off, then the tagging of files is done with normal regular expressions (see ed (1)).
    When Case sensitive checkbox is on, the selection will be case sensitive characters.
    If Case sensitive is off, the case will be ignored.

:\: (backslash) use the "\" key to unselect a group of files. This is the opposite of the Plus key.

:up-key, C-p: move the selection bar to the previous entry in the panel.

:down-key, C-n: move the selection bar to the next entry in the panel.

:home, a1, Alt-<: move the selection bar to the first entry in the panel.

:end, c1, Alt->: move the selection bar to the last entry in the panel.

:next-page, C-v: move the selection bar one page down.

:prev-page, Alt-v: move the selection bar one page up.

:Alt-o: If the currently selected file is a directory, load that directory on the other panel
        and moves the selection to the next file.
        If the currently selected file is not a directory, load the parent directory on the other panel
        and moves the selection to the next file.

:Alt-i: 在另一個 panel 中，開啟目前 panel 的目錄

:C-PageUp, C-PageDown: only when supported by the terminal:
                       change to ".." and to the currently selected directory respectively.

:Alt-y: moves to the previous directory in the history, equivalent to clicking the < with the mouse.

:Alt-u: moves to the next directory in the history, equivalent to clicking the > with the mouse.

:Alt-Shift-h, Alt-H: displays the directory history, equivalent to depressing the 'v' with the mouse.

Shell Command Line
------------------

This section lists keys which are useful to avoid excessive typing when entering shell commands.

:Alt-Enter: copy the currently selected file name to the command line.

:C-Enter: same a Alt-Enter. May not work on remote systems and some terminals.

:C-Shift-Enter: copy the full path name of the currently selected file to the command line.
                May not work on remote systems and some terminals.

:Alt-Tab: does the filename, command, variable, username and hostname completion for you.

:C-x t, C-x C-t: copy the tagged files (or if there are no tagged files, the selected file) of the current panel (C-x t)
                 or of the other panel (C-x C-t) to the command line.

:C-x p, C-x C-p: the first key sequence copies the current path name to the command line,
                 and the second one copies the unselected panel's path name to the command line.

:C-q: the quote command can be used to insert characters that are otherwise interpreted by the Midnight Commander
      (like the '+' symbol)

:Alt-p, Alt-n: use these keys to browse through the command history.
               Alt-p takes you to the last entry, Alt-n takes you to the next one.

:Alt-h: displays the history for the current input line.

General Movement Keys
---------------------

The help viewer, the file viewer and the directory tree use common code to handle moving. Therefore they accept exactly the same keys. Each of them also accepts some keys of its own.

Other parts of the Midnight Commander use some of the same movement keys, so this section may be of use for those parts too.

Up, C-p
moves one line backward.
Down, C-n
moves one line forward.
Prev Page, Page Up, Alt-v
moves one page up.
Next Page, Page Down, C-v
moves one page down.
Home, A1
moves to the beginning.
End, C1
move to the end.
The help viewer and the file viewer accept the following keys in addition the to ones mentioned above:
b, C-b, C-h, Backspace, Delete
moves one page up.
Space bar
moves one page down.
u, d
moves one half of a page up or down.

g, G

moves to the beginning or to the end.

Input Line Keys

The input lines (they are used for the command line and for the query dialogs in the program) accept these keys:

:C-a: puts the cursor at the beginning of line.

:C-e: puts the cursor at the end of the line.

:C-b, move-left: move the cursor one position left.

:C-f, move-right: move the cursor one position right.

:Alt-f: moves one word forward.

:Alt-b: moves one word backward.

:C-h, backspace: delete the previous character.

:C-d, Delete: delete the character in the point (over the cursor).

:C-@: sets the mark for cutting.

:C-w: copies the text between the cursor and the mark to a kill buffer and removes the text from the input line.

:Alt-w: copies the text between the cursor and the mark to a kill buffer.

:C-y: yanks back the contents of the kill buffer.

:C-k: kills the text from the cursor to the end of the line.

:Alt-p, Alt-n: Use these keys to browse through the command history.
               Alt-p takes you to the last entry, Alt-n takes you to the next one.

:Alt-C-h, Alt-Backspace: delete one word backward.

:Alt-Tab: does the filename, command, variable, username and hostname completion for you.
