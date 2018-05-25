.. slug: using-lftp-upload-website
.. date: 2013/11/14 11:35:13
.. description:
.. tags:
.. title: Using lftp upload website
.. link:
.. category: computer

為了將寫好的靜態網頁上傳到 server 上，用 lftp 真的很簡單。

install lftp
========================================================================

.. code::

	$ yaourt -S lftp

create backup.lftp
========================================================================

.. code::

    open <host url>
    user user-id user-pwd
    lcd local-dir/
    cd host-dir/
    mirro -Rnc
    exit

execute backup.lftp
========================================================================

.. code::

    $ lftp -f backup.lftp

reference:
========================================================================

.. code::

    mirror [OPTS] [source [target]]

           Mirror specified source directory to local target directory. If  the  target  directory  ends
           with  a  slash  (except the root), the source base name is appended to target directory name.
           Source and/or target can be URLs pointing to directories.

                -c,      --continue                continue a mirror job if possible
                -e,      --delete                  delete files not present at remote site
                         --delete-first            delete old files before transferring new ones
                         --depth-first             descend into subdirectories before transferring files
                -s,      --allow-suid              set suid/sgid bits according to remote site
                         --allow-chown             try to set owner and group on files
                         --ascii                   use ascii mode transfers (implies --ignore-size)
                         --ignore-time             ignore time when deciding whether to download
                         --ignore-size             ignore size when deciding whether to download
                         --only-missing            download only missing files
                         --only-existing           download only files already existing at target
                -n,      --only-newer              download only newer files (-c won't work)
                         --no-empty-dirs           don't    create    empty     directories     (implies
                                                   --depth-first)
                -r,      --no-recursion            don't go to subdirectories
                         --no-symlinks             don't create symbolic links
                -p,      --no-perms                don't set file permissions
                         --no-umask                don't apply umask to file modes
                -R,      --reverse                 reverse mirror (put files)
                -L,      --dereference             download symbolic links as files
                -N,      --newer-than=SPEC         download only files newer than specified time
                         --older-than=SPEC         download only files older than specified time
                         --size-range=RANGE        download only files with size in specified range
                -P,      --parallel[=N]            download N files in parallel
                         --use-pget[-n=N]          use pget to transfer every single file
                         --on-change=CMD           execute the command if anything has been changed
                         --loop                    repeat mirror until no changes found
                -i RX,   --include=RX              include matching files
                -x RX,   --exclude=RX              exclude matching files
                -I GP,   --include-glob=GP         include matching files
                -X GP,   --exclude-glob=GP         exclude matching files
                -f FILE, --file=FILE               mirror   a   single   file  or  globbed  group  (e.g.
                                                   /path/to/*.txt)
                -O DIR,  --target-directory=DIR    target base path or URL
                -v,      --verbose[=level]         verbose operation
                         --log=FILE                write lftp commands being executed to FILE
                         --script=FILE             write lftp commands to FILE, but don't execute them
                         --just-print, --dry-run   same as --script=-
                         --use-cache               use cached directory listings
                         --Remove-source-files     remove files after transfer (use with caution)
                -a                                 same as --allow-chown --allow-suid --no-umask

           When using -R, the source directory is local and the target is remote.  If the target  direc‐
           tory is omitted, base name of the source directory is used.  If both directories are omitted,
           current local and remote directories are used.  If the target directory  ends  with  a  slash
           (except the root directory) then base name of the source directory is appended.

           RX is an extended regular expression, just like in egrep(1).

           GP is a glob pattern, e.g. `*.zip'.

           Include  and  exclude options can be specified multiple times. It means that a file or direc‐
           tory would be mirrored if it matches an include and does not  match  to  excludes  after  the
           include,  or  does not match anything and the first check is exclude. Directories are matched
           with a slash appended.

           Note that symbolic links are not created when uploading to remote server, because ftp  proto‐
           col  cannot  do  it. To upload files the links refer to, use `mirror -RL' command (treat sym‐
           bolic links as files).

           For options --newer-than and --older-than you can either specify a file or time specification
           like that used by at(1) command, e.g.  `now-7days' or `week ago'. If you specify a file, then
           modification time of that file will be used.

           Verbosity level can be selected using --verbose=level option or by several -v  options,  e.g.
           -vvv. Levels are:
                0 - no output (default)
                1 - print actions
                2 - +print not deleted file names (when -e is not specified)
                3 - +print directory names which are mirrored

           --only-newer  turns  off  file size comparison and uploads/downloads only newer files even if
           size is different. By default older files are transferred and replace newer ones.

           You can mirror between two servers if you specify URLs instead of directories.  FXP  is  used
           automatically for transfers between ftp servers, if possible.

           Some  ftp  servers  hide  dot-files by default (e.g. .htaccess), and show them only when LIST
           command is used with -a option. In such case try to use `set ftp:list-options -a'.
