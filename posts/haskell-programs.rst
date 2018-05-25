.. title: 安裝 haskell 程式
.. slug: haskell-programs
.. date: 2014/04/29 10:27:14
.. tags: haskell, pandoc, xmonad
.. link:
.. description:
.. type: text
.. category: computer

目前我會用的 haskell 程式有 pandoc 和 xmonad。

原先我也是用 archlinux 中的 yaourt 安裝 haskell 的程式來用。但是有一天突然就不能用了，重裝也沒用。
我想，反正這些程式都是 haskell 人發展出來的，乾脆直接從 haskell 那裡安裝，就不必等 archlinux 的維護者。

先安裝 cabal：
::

   $ yaourt -S cabal-install

有了 cabal 就可以從 haskell 的軟體庫中直接安裝它的軟體。
::

   $ cabal install pandoc xmonad xmonad-contrib

如果有這麼簡單，何必再另外寫這一篇筆記。

**update:2015-1-26**

現在又直接用 cabal 安裝 haskell 的程式
::

   $ cabal update
   $ cabal install gtk2hs-buildtools xmonad xmonad-contrib taffybar pandoc dates

**以下是原來的做法，現在可以不必如此麻煩了** 保留這段只是備查

我碰到的問題是，安裝好 xmonad，也沒有報錯。執行時，總是出現某個 module not found。所以想重裝試試。
很可惜，下了 ``cabal install`` 的指令，會得到
::

   cabal: The following packages are likely to be broken by the reinstalls:
   xmonad-contrib-0.11.2
   xmonad-contrib-0.11.2
   Use --force-reinstalls if you want to install anyway.

那就強制安裝吧，可惜的是，不能成功。昏！

拜 google 大神吧！好不容易找到了這一篇說明為何有上述的問題，原來是所謂的 `cabal hell
<https://www.fpcomplete.com/user/simonmichael/how-to-cabal-install>`_ 。

詳細的就看這篇的說明，我的作法就很簡單：抄。
在 ~/.bashrc 中加入：
::

   # ghc-pkg-reset
   # Removes all installed GHC/cabal packages, but not binaries, docs, etc.
   # Use this to get out of dependency hell and start over, at the cost of some rebuilding time.
   function ghc-pkg-reset() {
       read -p 'erasing all your user ghc and cabal packages - are you sure (y/n) ? ' ans
       test x$ans == xy && ( \
           echo 'erasing directories under ~/.ghc'; rm -rf `find ~/.ghc -maxdepth 1 -type d`; \
           echo 'erasing ~/.cabal/lib'; rm -rf ~/.cabal/lib; \
       )
   }

簡單的說就是把 ~/.ghc 下的資料刪掉，然後重新安裝 haskell 的程式。
::

   $ ghc-pkg-reset
   $ cabal install --reinstall pandoc xmonad-contrib

真的就成功了。

終於又可以開始玩 xmonad。 :doc:`tiling-window-manager-xmonad-with-kde` 。

**update 2014-5-6** 不要用 haskell-core 的方式，因為它的程式不完整，也不是最新的。

昨晚想 update 一下系統，沒想到 haskell 又耍寶不能用，造成整個 archlinux 都不能更新。真不爽。

還好，archlinux 的人知道這種狀況， `wiki <https://wiki.archlinux.org/index.php/Haskell_Package_Guidelines#.5Bhaskell-core.5D>`_ 中已經有可行對策。

   [haskell-core]
   The [haskell-core] repository is the base repository of packages maintained by the ArchHaskell team.
   [haskell-core] can be accessed by adding the following entry to /etc/pacman.conf (above [extra]):
   ::

      [haskell-core]
      Server = http://xsounds.org/~haskell/core/$arch

然後再執行：
::

   # pacman-key -r 4209170B
   # pacman-key --lsign-key 4209170B
   # pacman -Syy

先把 haskell 相關的 cabal 砍掉，再用 yaourt 重裝就可以，只是要花不少時間。
::

   $ ghc-pkg-reset
   $ yaourt -Rscn cabal-install
   $ yaourt -S ghc haskell-xmonad-contrib haskell-pandoc

重裝後，即可使用。
