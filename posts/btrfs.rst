.. slug: btrfs
.. link:
.. title: btrfs 使用筆記
.. tags: btrfs, linux
.. category: computer
.. description:
.. date: 2013/04/28 12:43:24

btrfs
===================

試試看新的 filesystem

2013/4/30 update: 問題還很多。

1. 明明還有空間，卻會回報「空間用完」，試着在刪除一些檔案，空間還是不足。
2. 速度上明顯比 ext4 慢。

等到真的穩定了再來用吧。還是回頭先用 LVM 這個比較穩定的系統。

安裝 btrfs 工具
-------------------
::

    $ sudo pacman -S btrfs-progs

Format
---------------------

我有 2 顆硬碟，用來裝電影，不需要用到 RAID1 做備份。
因此，我是用 RAID0 將這 2 顆硬碟變成一顆大硬碟，管理上比較方便。

::

    # 確認硬碟代碼
    $ lsblk -f

    # format 成 btrfs 格式
    $ mkfs.btrfs -m raid0 /dev/sdb /dev/sdc

    # 再確認 UUID
    $ lsblk -f

Mount
------------------------

mount 時，隨便用那一顆硬碟的代碼都行：
::

    $ mount /dev/sdb /mnt/movie

修改 /etc/fstab，開機時可自動掛上：
::

    UUID=<UUID>     /mnt/movie      btrfs           defaults,compress=lzo        0       0

簡單設定如上。

平衡 2 顆硬碟的負載
-----------------------
::

    $ btrfs filesystem balance /mnt/movie

The balance operation will take some time.
It reads in all of the FS data and metadata and rewrites it across the new device.

可以看看 btrfs 磁碟的狀況
--------------------------
::

    $ btrfs filesystem show

    Label: none  uuid: 3f5fe016-9af6-4910-9671-889b0ccfcfcd
    Total devices 2 FS bytes used 344.88GB
    devid    2 size 931.51GB used 173.00GB path /dev/sde
    devid    1 size 931.51GB used 173.00GB path /dev/sdc

2 顆硬碟的用量果然平衡。


Changing RAID Level
-------------------------
::

    btrfs balance start -dconvert=raid1 -mconvert=raid1 /mnt

dd_

.. _dd: http://www.howtoforge.com/a-beginners-guide-to-btrfs-p2


新增刪除 device
----------------------------------------------

不小心把磁碟用完了，想刪除一些沒用的檔案，竟然也失敗。
還好先前有練習用的 /dev/sdb8，把它加上去看看，有沒有救。
::

    $ sudo btrfs device add /dev/sdb9 /mnt/movie

還好成功了。處理完畢，刪掉它。
::

    $ sudo btrfs device delete /dev/sdb9 /mnt/movie

在這個過程中，意外發現另一件事：當我把 /dev/sdb9 加上後，原先在 sdb9 的資料就消失啦。
意味着 btrfs 不夠聰明到可以保留原本的資料。



參考資料
=================

`Btrfs: Archlinux wiki <https://wiki.archlinux.org/index.php/Btrfs>`_

`Btrfs wiki: Main page <https://btrfs.wiki.kernel.org/index.php/Main_Page>`_

`Btrfs wiki: Using Btrfs with Multiple Devices <https://btrfs.wiki.kernel.org/index.php/Using_Btrfs_with_Multiple_Devices>`_

`Btrfs wiki: Mount Options <https://btrfs.wiki.kernel.org/index.php/Mount_options>`_

`Btrfs wiki: UseCases <https://btrfs.wiki.kernel.org/index.php/UseCases>`_


Device scanning
--------------------
btrfs device scan is used to scan all of the block devices under /dev and probe for Btrfs volumes. This is required after loading the btrfs module if you're running with more than one device in a filesystem.
::

    # Scan all devices
    $ btrfs device scan

    # Scan a single device
    $ btrfs device scan /dev/sdb

btrfs filesystem show will print information about all of the btrfs filesystems on the machine.

Adding new devices
--------------------------

btrfs filesystem show gives you a list of all the btrfs filesystems on the systems and which devices they include.
btrfs device add is used to add new devices to a mounted filesystem.
btrfs filesystem balance can balance (restripe) the allocated extents across all of the existing devices. For example:
::

    $ mkfs.btrfs /dev/sdb
    $ mount /dev/sdb /mnt

    # Create some files
    $ btrfs device add /dev/sdc /mnt

At this point we have a filesystem with two devices, but all of the metadata and data are still stored on /dev/sdb. The filesystem must be balanced to spread the files across all of the devices.
::

    $ btrfs filesystem balance /mnt

The balance operation will take some time. It reads in all of the FS data and metadata and rewrites it across the new device.

Conversion
-------------------
A non-raid filesystem is converted to raid by adding a device and running a balance filter that will change the chunk allocation profile.
For example, to convert an existing single device system (/dev/sdb1) into a 2 device raid1 (to protect against a single disk failure):
::

    mount /dev/sdb1 /mnt
    btrfs device add /dev/sdc1 /mnt
    btrfs balance start -dconvert=raid1 -mconvert=raid1 /mnt

If the metadata is not converted from the single-device default, it remains as DUP, which does not guarantee that copies of block are on separate devices. If data is not converted it does not have any redundant copies at all.
