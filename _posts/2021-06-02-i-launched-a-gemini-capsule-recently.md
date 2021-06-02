---
title: i launched a gemini capsule recently
date: 2021-06-02T22:36:43+03:00
author: la-ninpre
tags: gemini openbsd
---

i launched my own gemini capsule, yay!

it is available on the same domain, just type `gemini://aaoth.xyz` in your
favourite gemini client.

<!--more-->

for those of you that don't know, gemini is a relatively new internet protocol.
it is already gained popularity among some enthusiasts out there.

it is intended to be simple and lightweight, it's just plaintext. and the whole
specification is so simple that usable server and/or client for it could be
written within about 100 lines of code.

learn more on:

[gemini website](https://gemini.circumlunar.space)

## about quirks and vger

firstly i looked through the list of gemini servers on gemini website.
and one particular server there attracted me. it was `vger`.
it is saying that it is secure and openbsd-centric.

so i tried installing it. it is even packaged for openbsd, which was pretty
convenient, even though i don't mind building stuff from source.
especially if it is not a big bloated thing.

and surprisingly the configuration was **so** simple, that i even hadn't
realized it for a first couple of minutes.
but then i wanted to launch some fancy cgi things, such as, for example,
gemlikes. it is providing simple like and comment system for a blog.

and there vger failed me. maybe it is me failed myself, but i tried all
possible configuration options. i think, for now vger is not capable of
running cgi scripts for some parts of the capsule.

in other words, i'm talking about this.
consider some capsule with tld `gemini://example.com`.
it serves some static pages on `gemini://example.com/blog/*` and
`gemini://example.com/about.gmi`.
gemlikes need three binaries and a `gemlikes.toml` config file.
they suggest placing them in `/cgi-bin/gemlikes/`.
i placed them there, but i couldn't make it so it is how it needs to be.
my vger is serving only cgi or only static pages.

## another try

so i looked though a list again, and found `gmid` there. it seemed like
a good option too, because it's written in c and openbsd-aware too.

and this was nice expirience, because gmid's config file is very
similar to other openbsd's tool configs, such as relayd or httpd.
the only peculiarity with gmid is that it's not yet packaged for
openbsd, so i had to compile it manually. and also i created the daemon
script for it in rc.d(8).

here it is, if you need it:

/etc/rc.d/gmid
```sh
#!/bin/ksh

daemon="/usr/local/bin/gmid"
daemon_flags="-c /etc/gmid.conf"

. /etc/rc.d/rc.subr

rc_pre() {
    ${rcexec} "${daemon} -n ${daemon_flags}"
}

rc_cmd $1
```

and of course, my config is in `/etc/gmid.conf`. manpage of gmid contains
very good descriptions of all the options available.

## thoughts about geminispace

my first impressions of gemini were a little odd. it's a little bit hard
to read just text, when you are used to graphically overwhelming
flashing websites with pictures and interactive stuff.
but after a little bit of time comes the appretiation of the beauty
of the pure text. 

i can see gemini as a perfect place to host some informative resources,
personal blogs and also for creative writing.
and especially the latter, because it is so easy to spin up your own
instance, i can see at as a great option for writers out there to
host their content.
