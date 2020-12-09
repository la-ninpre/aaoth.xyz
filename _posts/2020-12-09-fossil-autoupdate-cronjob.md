---
title: auto-update fossil using cron(8)
tags: openbsd tutorial fossil
date: 2020-12-09T01:37+03:00
---

i'm running an instance of fossil on my openbsd server (it's the same that is
powering this website) and for some reason i want it to be up-to-date. more
presicely, bleeding edge.

<!--more-->

for that i added this part to my `daily.local` script (for those of you who
don't know, it's script that running every day by cron(8)):

```
cd /root/fossil && \
    /usr/local/bin/fossil up | \
    awk '/changes:/ {
        if ($2 == "None."){
            print "No changes, exiting...";
            exit 1
        }else{
            out="";
            for(i=2; i<=NF; i++){
                out=out" "$i
            };
        }
        print out;
        exit 0
    }' && \
    /usr/local/bin/fossil revert src/repolist.c >/dev/null && \
    patch src/repolist.c /var/www/htdocs/fsl.aaoth.xyz/repolist.c.patch \
        >/dev/null && \
    ./configure --static >/dev/null && \
    make >/dev/null && \
    cp fossil /var/www/bin && \
    make distclean >/dev/null && \
    /usr/local/bin/fossil stat
```

it is very straightforward and simple. firstly, it's changing directory into
place, where i have fossil checkout (made with `fossil clone` and
`fossil open`). then it runs `fossil up` and piping it to a small awk script
that is checking, is there any changes pulled down.

after that there's one interesting part. `fossil revert src/repolist.c` is there
because i modified it a little bit to make my [repolist][1] page look better.
after my edits, i exported a patch by executing:

```
fossil diff > repolist.c.patch
```

maybe it would be better if i committed those changes, but i don't want to hold
a full fossil repo among my other fossils, because its history is fairly long.
and also i'm not very good at c programming, so i'll keep it as is for now.
if you're interested this patch is free to use and you can [check it out][2].

after that, there's just a normal configure and make procedure and also final
cleanup.

i also have a mail server running there, so i get an email of what changes were
applied and that everything went fine.

[1]:https://fsl.aaoth.xyz
[2]:https://fsl.aaoth.xyz/repolist.c.patch
