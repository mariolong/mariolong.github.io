.. title: emacs-ido 設定
.. slug: emacs-ido
.. date: 2014/05/15 08:10:54
.. tags: emacs
.. link:
.. description:
.. type: text

廢棄不用了，我現在先只用 helm

ido

ido-ubiquitous

ido-vertical-mode

(setq ido-everywhere t)

ido-vertical-mode
============================================================



Turn it on
--------------------------------------------------
::

   (require 'ido-vertical-mode)
   (ido-mode 1)
   (ido-vertical-mode 1)

Or you can use M-x ido-vertical-mode to toggle it.

快速鍵
--------------------------------------------------

Since the prospects are listed vertically, it makes sense to use C-n/C-p to navigate through the options. These are added to the ido-completion-map by default (and ido-toggle-prefix, previously on C-p, is moved to M-p).

You also have the option to rebind some or all of the arrow keys with ido-vertical-define-keys:

(setq ido-vertical-define-keys 'C-n-C-p-up-down)
to use up and down to navigate the options, or

(setq ido-vertical-define-keys 'C-n-C-p-up-down-left-right)
to use left and right to move through the history/directories.

Semx
============================================================

Smex is a M-x enhancement for Emacs. Built on top of Ido, it provides a convenient interface to your recently and most frequently used commands. And to all the other commands, too.

http://sachachua.com/blog/2014/03/emacs-basics-call-commands-name-m-x-tips-better-completion-using-ido-helm/

Ido, ido-hacks, smex, ido-vertical-mode, and flx-ido

http://ergoemacs.org/emacs/emacs_name_completion.html
