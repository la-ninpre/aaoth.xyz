---
title: run cgit on openbsd
date: 2021-01-06T13:30+03:00
author: la-ninpre
tags: openbsd git tutorial
---

i started using git for my personal pet projects. a little time then i decided
that it would be a nice idea to make them as open as i can. i use github, but
to support that idea of self-hosting, i wanted some free and easy web frontend
to git. cgit is one of the most popular ones, but it was kinda tough to run on
openbsd.

<!--more-->

i know gitweb exists, but i just like cgit more.

cgit is quite easy to install still, but needs some work done, it's not like
two commands.

[official cgit page][1] has some installation instructions. it mentions that
it's distributed in binary form for some linux distros, but of course openbsd's
not there, so we'll need to build it from source.

first of all, i wanted to use openbsd's native web server`httpd` and native
fastcgi server -- `slowcgi`.
the issue is that openbsd's httpd web server lives in chroot-jail and that fact
is complicating the configuration.
but before we need to build cgit from source.

## building cgit

to do that, clone cgit source code from [official cgit page][1]
(or if you like [my cgit page][2], you can clone it instead):

```
$ git clone https://git.zx2c4.com/cgit
```

then move to this directory:

```
$ cd cgit
```

there are some source files and a Makefile. by default, it'll install cgit in
`/var/www/htdocs/cgit`. if you want a different path, make corresponding change
in a Makefile by editing `CGIT_SCRIPT_PATH` variable.

but before compiling cgit itself, we need to init and build git submodule
(i suppose, this is the source code of git itself that is needed to make some
git operations on repositories):

```
$ git submodule init
$ git submodule update
```

and then we can compile cgit. note that gnu version of make utility is used,
install `gmake` from openbsd repositories (`doas pkg add gmake`):

```
$ gmake && doas gmake install
```

notice that this command should be executed by user who has write permissions
to `/var/www` and `/usr/local/lib` (usually root).

when it's done, the rest is to create directories needed for cgit to work
and also to configure `httpd` and `slowcgi`.

## creating directories and dev/null

cgit uses following files to work:
- `/etc/cgitrc` -- needed for configuration
  (see [man page][3] for available options)
- `/var/cache/cgit` -- cache that is used by cgit to reduce cpu usage
- `/var/www/htdocs/cgit/`
  - `cgit.css` -- stylesheet
  - `cgit.png` -- logo
  - `favicon.ico` -- favicon
  - `robots.txt` -- instructions for indexers
- `/usr/local/lib/cgit/*` -- different filters and stuff
  (i didn't need it at all, because it's hard to make it work in a chroot)
- `/dev/null` -- i don't know exactly why it's needed, but it won't work without
  it

because cgit will run in chroot-jail, all those files and directories except
`/var/www/htdocs/cgit` should be located in `/var/www`
(e.g. `/var/www/etc/cgitrc` and so on).

```
$ doas mkdir -p /var/www/{cache/cgit,dev,etc,usr/lib,usr/libexec}
$ doas chown -R www:www /var/www/{cache/cgit,htdocs/cgit}
```

`/dev/null` is not a regular file, it's a device, so it must be created using:

```
$ doas install -d -g daemon /template/dev
$ cd /template/dev
$ doas mknod -m 666 null c 2 2
$ doas mount_mfs -s 1M -P /template/dev /dev/sd0b /var/www/dev
```

this instruction is taken from [fossil docs][4].

## copying libraries

since cgit is not linked statically, it also needs some dynamic libraries.
they all need to be accessible from chroot, so we need to copy them to
`/var/www/usr/lib`. to check, what should be copied, run:

```
$ ldd /var/www/htdocs/cgit/cgit.cgi

/var/www/htdocs/cgit/cgit.cgi:
	Start            End              Type  Open Ref GrpRef Name
	00000b068a590000 00000b068a7b6000 exe   2    0   0      /var/www/htdocs/cgit/cgit.cgi
	00000b0927dcb000 00000b0927de7000 rlib  0    1   0      /usr/lib/libz.so.5.0
	00000b0937409000 00000b093750b000 rlib  0    2   0      /usr/local/lib/libiconv.so.7.0
	00000b0978c28000 00000b0978c37000 rlib  0    1   0      /usr/local/lib/libintl.so.7.0
	00000b091fdc0000 00000b091fdcc000 rlib  0    2   0      /usr/lib/libpthread.so.26.1
	00000b0920331000 00000b09203be000 rlib  0    1   0      /usr/local/lib/libluajit-5.1.so.1.0
	00000b091cc5f000 00000b091cd54000 rlib  0    1   0      /usr/lib/libc.so.96.0
	00000b089fffb000 00000b08a002b000 rlib  0    1   0      /usr/lib/libm.so.10.1
	00000b08b2542000 00000b08b2585000 rlib  0    1   0      /usr/lib/libc++abi.so.3.0
	00000b08cebc7000 00000b08cebc7000 ld.so 0    1   0      /usr/libexec/ld.so
```

and it'll return a list of all dependencies. copy them to `/var/www/lib`:

```
$ doas cp /usr/lib/{libz.so.5.0,libpthread.so.26.1,libc.so.96.0,libm.so.10.1,libc++abi.so.3.0} /var/www/lib
$ doas cp /usl/local/lib/{libiconv.so.7.0,libintl.so.7.0,libluajit-5.1.so.1.0} /var/www/lib
$ doas cp /usr/libexec/ld.so /var/www/usr/libexec
```

you should be able now to test cgit using this command:

```
$ doas chroot -u www /var/www /htdocs/cgit/cgit.cgi
```

it should return no errors but a webpage.

## configuring cgit

as already mentioned, cgit is configured using `/var/www/etc/cgitrc`. i suggest
reading [manpage][3] for detailed overview of all available options, but here's
an example cgitrc to start with:

```
#cache
cache-size=1000
cache-dynamic-ttl=60
cache-static-ttl=44640
cache-root-ttl=6
cache-repo=5

#index page
enable-index-links=1
enable-index-owner=0
max-repodesc-length=60
root-title=aaoth's git repos
root-desc=some personal projects

#repo global
enable-git-config=1
enable-commit-graph=1
enable-follow-links=1
enable-blame=1
enable-http-clone=1
enable-log-filecount=1
enable-log-linecount=1
enable-html-serving=1
branch-sort=age
snapshots=tar.gz zip
side-by-side-diffs=0
max-stats=week

#root
readme=:README.md
readme=:readme.md
readme=:README
readme=:readme

#mimetypes
mimetype.html=text/html
mimetype.gif=image/gif
mimetype.jpg=image/jpeg
mimetype.jpeg=image/jpeg
mimetype.png=image/png
mimetype.svg=image/svg+xml
mimetype.pdf=application/pdf

scan-path=/git
```

some of the settings are omitted, but you can tweak it further as you wish.

note that i use autoscan feature of cgit. i have all my repos located in
`var/www/git` as described by `scan-path` option.
all of them are chowned by www user and have `cgitrc` text file inside.

each repo-specific `cgitrc` looks like this:

```
name=test_repo
desc=test repository to test cgit
owner=username
max-stats=month
```

## configuring httpd and slowcgi

and now the last part is to actually serve cgit using httpd and slowcgi

first of all, enable and start slowcgi:

```
$ doas rcctl enable slowcgi
$ doas rcctl start slowcgi
```

then edit your `/etc/httpd.conf`, you need to create a simple server statement

```
server "example.com" {

    listen on egress port 80
    root "/htdocs/cgit"

    location "/cgit.css" {
        root "/htdocs/cgit"
    }

    location "/cgit.png" {
        root "/htdocs/cgit"
    }

    location "/robots.txt" {
        root "/htdocs/cgit"
    }

    location "/favicon.ico" {
        root "/htdocs/cgit"
    }

    location "/*" {
        fastcgi {
            socket "/run/slowcgi.sock"
            param SCRIPT_FILENAME "/htdocs/cgit/cgit.cgi"
        }
    }
}
```

i know it can seem *very* odd, but it's the only way it works for me. as always,
all improvement suggestions are welcome.

and finally, (re-)start httpd:

```
$ doas rcctl enable httpd
$ doas rcctl start httpd
```

[1]:https://git.zx2c4.com/cgit
[2]:https://git.aaoth.xyz/cgit/cgit.git
[3]:https://git.zx2c4.com/cgit/tree/cgitrc.5.txt
[4]:https://www.fossil-scm.org/home/doc/trunk/www/server/openbsd/fastcgi.md#chroot
