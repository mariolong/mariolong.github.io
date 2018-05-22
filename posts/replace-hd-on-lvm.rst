.. title: replace hd on LVM
.. slug: replace-hd-on-lvm
.. date: 2015-06-11 23:52:30 UTC
.. tags: linux
.. category: computer
.. link:
.. description:
.. type: text

lvm 上的一顆硬碟壞了，要換掉。

整個過程並不像網上查到的那麼順利，所以，還是記錄下來，以備不時之需。

參考 `Replace one of the physical volumes in an LVM volume group <http://www.microhowto.info/howto/replace_one_of_the_physical_volumes_in_an_lvm_volume_group.html>`_
，鳥哥的 LINUX 私房菜，
和 `Archlinux Wiki <https://wiki.archlinux.org/index.php/LVM>`_

為了行文方便，先做以下說明：
::

   /dev/sdd 是壞掉的硬碟
   /dev/sdb 是新的硬碟


步驟
====

1. 準備好要加入 LVM 的硬碟，並用 gparted 設定為 lvm pv。
   有人是用 ``pvcreate`` ，反正功能是一樣的，就不必想太多，能完成工作就好。

#. 將新硬碟加入 VG::

     $ sudo vgextend VG01 /dev/sdb1

#. 資料移到新硬碟::

     $ sudo pvmove /dev/sdd1 /dev/sdb1

#. 檢查是否移動完成
   ::

      $ sudo pvs

      PV         VG   Fmt  Attr PSize   PFree
      /dev/sdb1  VG01 lvm2 a--    1.36t      0
      /dev/sdd1  VG01 lvm2 a--  931.51g 931.51g

      $ sudo pvdisplay

      --- Physical volume ---
      PV Name               /dev/sdd1
      VG Name               VG01
      PV Size               931.51 GiB / not usable 4.00 MiB
      Allocatable           yes
      PE Size               4.00 MiB
      Total PE              238466
      Free PE               238466
      Allocated PE          0

#. 縮小 lv
   ::

      $ sudo resize2fs -M /dev/VG01/LV00
      $ sudo lvresize -l -238466 /dev/VG01/LV00
      $ sudo resize2fs /dev/VG01/LV00

#. 移除舊硬碟
   ::

      $ sudo vgreduce VG01 /dev/sdd1
      Removed "/dev/sdd1" from volume group "VG01"

      $ sudo pvremove /dev/sdd1
      Labels on physical volume "/dev/sdd1" successfully wiped


ISSUE
=====

縮小 lv
-------

要縮小 lv 時，先要將 file system 縮小，否則開機時，會報錯。

我的作法是將 file system 降至最低，就不必去計算要留多少。

然後，縮小 lv。

最後，再把 file system 放到最大即可。
::

   $ sudo resize2fs -M /dev/VG01/LV00
   $ sudo lvresize -l -238466 /dev/VG01/LV00
   $ sudo resize2fs /dev/VG01/LV00

pvmove
------

pvmove 時，不知為何沒將所有的 PE 都移動到新的硬碟，結果重做一次後就好了。
::

   $ sudo pvdisplay
   $ sudo lvresize -l -238466 /dev/VG01/LV00


後記
====

這次的工作一直卡在縮小 lv 的地方，因為沒有先縮小 file system，造成 fsck 會報錯，然後就無法開機。

雖然在試誤的過程中，一直擔心硬碟中的資料會毀損，最後的結果是好的，沒有任何資料毀損。

真是慶幸。
