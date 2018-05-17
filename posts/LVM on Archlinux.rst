.. slug: LVM-on-archlinux
.. link:
.. title: LVM on Archlinux
.. tags: Linux
.. description:
.. date: 2013/04/30 12:41:30

參考 `Archlinux wiki <https://wiki.archlinux.org/index.php/LVM>`_，
因爲這篇 wiki 中提到了 :doc:`btrfs <btrfs>` ，花了一些時間去研究它，結果不好用。

還是回來用 LVM，我只是要他的可擴充性：硬碟不夠時，再加一顆就好。

建立 LVM
========================================================================

pv 階段
---------------------------------------------------

用 gparted 設定，將要用的分區格式化成 lvm2 pv 即可。

pvdisplay 看看::

    $ sudo pvdisplay
    --- Physical volume ---
    PV Name               /dev/sdb8
    VG Name               VG00
    PV Size               15.04 GiB / not usable 0
    Allocatable           yes (but full)
    PE Size               4.00 MiB
    Total PE              3849
    Free PE               0
    Allocated PE          3849
    PV UUID               76qMPb-k4bl-jHVi-w0d6-DqEO-ffpq-l2jnpU

    --- Physical volume ---
    PV Name               /dev/sdb9
    VG Name               VG00
    PV Size               15.13 GiB / not usable 2.00 MiB
    Allocatable           yes (but full)
    PE Size               4.00 MiB
    Total PE              3874
    Free PE               0
    Allocated PE          3874
    PV UUID               nuSNwv-w4kq-VOrG-7zSI-jom6-MDTY-01yZps

vg 階段
--------------------------------------------------------

建立以 VG00 爲名的 VG::

    $ lsblk -f
    $ vgcreate VG00 /dev/sdb8
    $ vgextend VG00 /dev/sdb9
    $ vgdisplay
    --- Volume group ---
      VG Name               VG00
      System ID
      Format                lvm2
      Metadata Areas        2
      Metadata Sequence No  3
      VG Access             read/write
      VG Status             resizable
      MAX LV                0
      Cur LV                1
      Open LV               0
      Max PV                0
      Cur PV                2
      Act PV                2
      VG Size               30.17 GiB
      PE Size               4.00 MiB
      Total PE              7723
      Alloc PE / Size       7723 / 30.17 GiB
      Free  PE / Size       0 / 0
      VG UUID               BslpFB-0DUQ-PHdf-BAIj-o7WC-fWQ0-7PkJNe

lv 階段
---------------------------------------------------------

建立以 LV00 爲名的 LV
::

    $ lvcreate -l +100%FREE VG00 -n LV00
    $ lvdisplay
      --- Logical volume ---
      LV Path                /dev/VG00/LV00
      LV Name                LV00
      VG Name                VG00
      LV UUID                d0MSXz-bcmL-XZ3R-gjyR-X1C7-P0y0-ODe0uM
      LV Write Access        read/write
      LV Creation host, time arch-64, 2013-04-30 13:11:43 +0800
      LV Status              available
      # open                 0
      LV Size                30.17 GiB
      Current LE             7723
      Segments               2
      Allocation             inherit
      Read ahead sectors     auto
      - currently set to     256
      Block device           254:0

Create filesystems and mount logical volumes
------------------------------------------------------------

::

    $ modprobe dm-mod
    $ vgscan

      Reading all physical volumes.  This may take a while...
      Found volume group "VG00" using metadata type lvm2

    $ vgchange -ay

      1 logical volume(s) in volume group "VG00" now active

format and mount::

    $ mkfs.ext4 /dev/mapper/VG00-LV00
    $ mount /dev/mapper/VG00-LV00 /mnt/lvmtest

Add lvm hook to mkinitcpio.conf
--------------------------------------------------------

You'll need to make sure the udev and lvm2 mkinitcpio hooks are enabled.
udev is there by default.
Edit the file and insert lvm2 between block and filesystem like so::

    $ nano /etc/mkinitcpio.conf
    HOOKS="base udev ... block lvm2 filesystems"

Afterwards, you can continue in normal installation instructions with the create an initial ramdisk step.

Load proper module::

    $ modprobe dm_mod

The dm_mod module should be automatically loaded. In case it does not, you can try::

    $ nano /etc/mkinitcpio.conf
    MODULES="dm_mod ..."

rebuild::

    $ mkinitcpio -p linux


auto mount by /etc/fstab
---------------------------------------------------------

::

    $ nano /etc/fstab
    UUID=<LV UUID>      /mnt/lvmtest    ext4    defaults    0   0


增加一顆硬碟
========================================================================

確定要加入那顆硬碟
::

	$ lsblk -f
	
做好 partition，
將那顆硬碟設為 lvm pv
::
	
	$ gparted
	$ lsblk -f
	
	NAME          FSTYPE                        LABEL    UUID                                   MOUNTPOINT
	sdd                                                                                         
	└─sdd1        LVM2_member                            hr0IbE-tO9I-vm9d-1x8f-iJwq-mrHj-bT0Pth 
	  └─VG01-LV00 ext4                                   86068ca8-289d-480a-87db-2680b13d00e3   /mnt/data-lvm
	sde           promise_fasttrack_raid_member                                                 
	└─sde1        LVM2_member                            CGrblY-v1n3-Lzil-iwym-3Wyk-wPQS-Gqztrn 


pvcreate
::

	$ sudo pvcreate /dev/sde1
	Physical volume "/dev/sde1" successfully created
	
	$ sudo vgdisplay
	  --- Volume group ---
	  VG Name               VG01
	  System ID             
	  Format                lvm2
	  Metadata Areas        3
	  Metadata Sequence No  3
	  VG Access             read/write
	  VG Status             resizable
	  MAX LV                0
	  Cur LV                1
	  Open LV               1
	  Max PV                0
	  Cur PV                3
	  Act PV                3
	  VG Size               3.18 TiB
	  PE Size               4.00 MiB
	  Total PE              834631
	  Alloc PE / Size       476932 / 1.82 TiB
	  Free  PE / Size       357699 / 1.36 TiB
	  VG UUID               8uHaKD-23zK-W5by-EJPE-5hpN-3PmN-6yY1Wl
	
vgextend
::
	
	$ sudo vgextend VG01 /dev/sde1
	Volume group "VG01" successfully extended

	$ sudo lvdisplay
	  --- Logical volume ---
	  LV Path                /dev/VG01/LV00
	  LV Name                LV00
	  VG Name                VG01
	  LV UUID                0GSsZv-vzJQ-7mMk-rwsH-or0D-cDjJ-4OQFGd
	  LV Write Access        read/write
	  LV Creation host, time arch-64, 2013-04-30 19:20:38 +0800
	  LV Status              available
	  # open                 1
	  LV Size                1.82 TiB
	  Current LE             476932
	  Segments               2
	  Allocation             inherit
	  Read ahead sectors     auto
	  - currently set to     256
	  Block device           254:0

擴增剛剛設好的 lv
::

	$ lvextend -l +100%FREE VG01/LV00

df 看一下，發現 lv 容量還沒有增加
::

	$ df
	檔案系統               1K-blocks       已用      可用 已用% 掛載點
	/dev/mapper/VG01-LV00 1922728752 1798892248  26144448   99% /mnt/data-lvm

原來是，還要 resize file system
::

	＄ resize2fs /dev/VG01/LV00

df 看一下，發現 lv 容量增加囉
::

	$ df
	檔案系統               1K-blocks       已用       可用 已用% 掛載點
	/dev/mapper/VG01-LV00 3364872816 1798895476 1409685920   57% /mnt/data-lvm


What is the maximum size of a single LV? 
========================================================================

ref: http://www.tldp.org/HOWTO/LVM-HOWTO/lvm2faq.html

The answer to this question depends upon the CPU architecture of your computer and the kernel you are a running:

For 2.4 based kernels, the maximum LV size is 2TB. For some older kernels, 
however, the limit was 1TB due to signedness problems in the block layer. 
Red Hat Enterprise Linux 3 Update 5 has fixes to allow the full 2TB LVs. 
Consult your distribution for more information in this regard.

For 32-bit CPUs on 2.6 kernels, the maximum LV size is 16TB.

For 64-bit CPUs on 2.6 kernels, the maximum LV size is 8EB. (Yes, that is a very large number.)
