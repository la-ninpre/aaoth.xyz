# dualboot linux and openbsd with grub

```data

date: 2021-11-03
author: la-ninpre
tags: openbsd, linux, grub, tutorial
```

i've been trying to dualboot openbsd with linux using grub on both bios and
uefi machines and here's a solution that i've come up with.

<!--more-->

there are some guides about this on the internet, but there's no single guide
that covers both bios and uefi. @rootbsd has a video where he shows how to
do this, but his solution has one little disadvantage. he's specifying drives
in a grub config using relative drive and partition numbers, such as
`(hd0,gpt2)`. since these numbers could be different if one inserts a new drive
to the computer, or changes drive order, the boot option could fail
(which happened).

all partitions and drives have their unique identifier -- uuid. there's no
direct way to specify uuid in grub configuration, but there is a workaround.

grub manual describes the `search` command which has an option to set root
device if it is found. so we can use it for our purposes.

## steps for dualbooting in bios/legacy mode

1. install linux system on one of your drives

2. reboot and boot from openbsd install media and install openbsd to other drive
or partition.

3. reboot and login to your linux system

4. open a terminal and run `blkid` or `lsblk -f` to get an output partition
uuids.

5. write the following at the bottom of `/etc/grub.d/40_custom`:

  ```grub.cfg

  menuentry 'OpenBSD' {
      search -su --no-floppy *UUID*
      chainloader +1
  }
  ```

  where *UUID* is the uuid of your openbsd partition (with type 'ufs2')

6. run either `update-grub` or `grub-mkconfig` depending on what distribution
you are using. consult your distro's wiki to find a way to update your grub
configuration with recent changes.

7. now reboot and you should see an openbsd's boot option in grub menu.

## steps for uefi system

for boot in uefi mode there are few differences. after installing openbsd
don't reboot, but choose **shell**. now cd into `/mnt` directory and
download `BOOTX64.EFI` from your desired openbsd mirror. for example:

```sh

# cd /mnt
# ftp https://cdn.openbsd.org/pub/OpenBSD/7.0/amd64/BOOTX64.EFI
# reboot
```

after that the only other difference is that `chainloader` directive should
be `chainloader /BOOTX64.EFI`.

all other steps are the same.
