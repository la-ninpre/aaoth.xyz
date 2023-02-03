# dualboot linux and openbsd with grub

```data

date: 2021-11-03
author: la-ninpre
tags: openbsd, linux, grub, tutorial
```

i've been trying to dualboot openbsd with linux using grub on both bios and
uefi machines and here's a solution that i've come up with.

there are some guides about this on the internet, but there's no single guide
that covers both bios and uefi. @rootbsd has a video where he shows how to
do this, but his solution has one little disadvantage. he's specifying drives
in a grub config using relative drive and partition numbers, such as
`(hd0,gpt2)`. since these numbers could be different if one inserts a new drive
to the computer, or changes drive order, the boot option could fail
(which happened).

all partitions and drives have their unique identifier -- uuid. there's no
direct way to specify uuid in grub configuration, but there is a workaround.
grub manual describes the `search` command which has an option to set the root
device if it is found. so we can use it for our purposes.

## dualbooting in bios/legacy mode

this guide assumes that you have two drives, one of which has linux system installed
and another has openbsd installed.

on linux system, use commands like `blkid` or `lsblk -f` to get a list of drives with
their uuids. there should be a partition with type 'ufs2' on a drive with openbsd installed.
write down or copy uuid of that partition.

depending on your linux distribution, you may have different options to edit
the grub config file. many distributions provide `/etc/grub.d` directory, which
has separate files that then get combined into `/boot/grub/grub.cfg`. if you have it,
then you can edit the `/etc/grub.d/40_custom` file, which is a good place
for custom boot options and such. if it is not your case, you can edit `grub.cfg` directly,
but note that it may be overwritten on a system update.

add this to your grub config (`40_custom` or `grub.cfg`, see above):

```grub.cfg

menuentry 'OpenBSD' {
	search -sun <UUID>
	chainloader +1
}
```

where \<UUID\> is the uuid of your openbsd partition (with type 'ufs2').

you can review options for a `search` command in grub's info page,
but basically they are needed to use uuid instead of drive number,
to set the root variable and to avoid searching floppies (which is not required,
but added just in case).

if you edited the `40_custom` file, don't forget to run `grub-mkconfig` or `update-grub`
(check your distribution's manual on updating the grub configuration).

after rebooting, you should see openbsd boot option in grub menu.

## dualbooting in uefi/gpt mode

openbsd creates few partitions if you choose gpt partitioning scheme during installation.
one of these partitions has fat12 file system and is of our interest.
on linux side you need to get its uuid.

as with bios/legacy boot described earlier, you need to add a boot option to grub,
but this time it's a bit different:

```grub.cfg

menuentry 'OpenBSD' {
	search -sun <UUID>
	chainloader /efi/boot/bootx64.efi
}
```

where \<UUID\> is the uuid of openbsd's fat12 partition.

don't forget to update grub configuration if you edited `40_custom` file.

this also works even if you used full-disk encryption on openbsd.
