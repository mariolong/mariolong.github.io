.. slug: geany-xin-de
.. link:
.. title: Geany使用心得
.. tags: Linux
.. description:
.. date: 2013/04/26 15:19:26

安裝
----------

    $ yaourt -S geany geany-plugins vte

geany 預設的快速鍵剛好也是 C-space，所以會衝突。把 geany 的快速鍵改掉。
我是改成 C-A-space，如此即可順利調用 fcitx。

配色
----------

配色方案放在 ``~/.config/geany/colorschemes`` 下。

鍵盤快速鍵
----------

設定樣板
-----------
在 ~/.config/geany/templates/files 下，建立一個易於辨識的檔名。以下爲範例

::

    .. slug:
    .. link:
    .. title:
    .. tags:
    .. description:
    .. date: {datetime}

開新檔時，可以用 ``檔案 > 開新檔案（利用範本）``，就會建立一個預先設定好內容的新檔。
如下：

::

    .. slug:
    .. link:
    .. title:
    .. tags:
    .. description:
    .. date: 2013/04/26 15:19:26

其中 ``{datetime}`` 參看 `Geany Help <file:///usr/share/doc/geany/html/index.html#file-templates>`_


Geany-Plugins
===============

Installation
---------------

You can build the plugins using either autotools or waf.

Building with autotools

You can use Autotools to build the Geany plugins in this repository.

Usage::

   ./configure [arguments] or alternatively ./autogen.sh [arguments]
  make
  sudo make install

This will configure, build and install most of the Geany plugins.
There is some auto-detection in place which automagically disables
some of the plugins if there are insufficient build dependencies.
The following arguments can tweak the behaviour of the configure
script:-

Options
=========
A full listing of all supported options can be found in ./configure --help.

Enable/Disable Features
==========================
The following options can be passed to ./configure in forms
--enable-<option>=auto (default), --enable-<option>, --disable-<option>. In all
cases, --enable-<option>=auto causes the feature to be enabled/disabled
automatically based on whether the dependency exists on your system.
--enable-<option> causes the feature to be forcefully enabled, causing configure
to fail with an error message if you have missing
dependencies. --disable-<option> causes the feature to be forcefully disabled.

Avaialble plugins are:

* addons -- the Addons plugin
* codenav -- the CodeNav plugin
* commander -- the Commander plugin
* debugger -- the Debugger plugin
* devhelp -- the devhelp plugin
* geanydoc -- the GeanyDoc plugin
* geanyextrasel -- the GeanyExtraSel plugin
* geanygendoc -- the GeanyGenDoc plugin
* geanyinsertnum -- the GeanyInsertNum plugin
* geanylatex -- the GeanyLaTeX plugin
* geanylipsum -- the GeanyLipsum plugin
* geanylua -- the GeanyLua plugin
* geanyminiscript -- the GeanyMiniScript plugin
* geanypg -- the geanypg plugin
* geanyprj -- the GeanyPrj plugin
* geanysendmail -- the GeanySendmail plugin
* geanyvc -- the GeanyVC plugin
* geniuspaste -- the paste to a pastebin plugin
* gproject -- the GProject plugin
* gtkspell -- GeanyVC's spell-check support
* markdown -- the Markdown plugin
* pretty_printer -- the pretty-printer plugin
* scope -- the Scope plugin
* shiftcolumn -- the ShiftColumn plugin
* spellcheck -- the spellcheck plugin
* treebrowser -- the Treebrowser plugin
* tableconvert -- the Tableconvert plugin
* updatechecker -- the Updatechecker plugin
* webhelper -- the WebHelper plugin
* xmlsnippets -- the XMLSnippets plugin
* extra-c-warnings -- extra C Compiler warnings (see also HACKING)
* cppcheck -- static code analysis using cppcheck (see also HACKING)

Example:
./configure --enable-geanylua --enable-spellcheck

This will force force both geanylua and spellcheck plugins to be enabled even
if some dependencies are missing.


Other tweaks
===============
The following options can be passed to ./configure in the form
--with-<option>=<argument>.

* lua-pkg -- the name of the lua pkg-config package name.
* geany-prefix -- Geany's prefix, used when compiling Geany.


Compiling Individual Plugins
===============================

The Geany Plugins project uses a recursive automake build system,
which means that after running ./configure, you may compile each
individual plug-in by cd-ing into the respective plug-in directory
and compiling it.

Building with waf
-----------------

Geany-Plugins can also being build using Python based build system waf.
For doing this you have similar to building with autotools run three steps::

    ./waf configure
    ./waf build
    ./waf install
