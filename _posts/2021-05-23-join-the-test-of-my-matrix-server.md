---
title: join the test of my matrix server
date: 2021-05-23T19:57:34+03:00
author: la-ninpre
tags: openbsd testing matrix
---

i launched my instance of [matrix][0] server recently. it runs on my openbsd vps
and the server software i'm using is [synapse][1]. homeserver address is
(unsurprizingly) `matrix.aaoth.xyz`.

i also launched an instance of [element][2] matrix web-client on
[element.aaoth.xyz][3], so you can try it.

[0]:https://matrix.org
[1]:https://matrix.org/docs/projects/server/synapse"
[2]:https://element.io
[3]:https://element.aaoth.xyz

<!--more-->

matrix is relatively new standard for instant messaging. the main reason i am
interested in it is that it's open-source. it means that anyone could launch
their instance of synapse and be happy with it.
it also means that the whole system is decentralized, providing protection
against global surveillance.

## about my server

after you create an account, you will be connected to the broadcast room.
it is unencrypted and read-only.
there are some links to other rooms.

note that everything going on with my server should be considered temporary
and i could be able to stop, disable or wipe everything completely,
so don't rely on this as production-ready tool.

also note that pretty much everything is in russian, because i launched matrix
primarily for my friends.

## about openbsd

here is a tutorial by the great man **robert d herb** who addressed a lot of
quirks installing synapse on openbsd, which helped me a lot:
[running a matrix homeserver with synapse and element][4]

because i haven't figured out completely how openbsd's relayd is working,
i broke my [fossils][5]. i hope i'll fix them later, but now they look messy.
there are some issues, i think, with internal structure of fossil's ui.
it needs to be served directly by httpd. but for synapse to work it is mandatory
to run relayd as reverse proxy.

if you know how to shift some portion of traffic to relayd and some to httpd,
please, [drop me a line][6].

[4]:https://robertdherb.com/things/matrix.html
[5]:https://fsl.aaoth.xyz
[6]:mailto:aaoth@aaoth.xyz
