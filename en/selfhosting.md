# selfhosting

all things `*.aaoth.xyz` that you can use or access. blocks of preformatted text
provide configuration options to use with appropriate clients.

## code

### cgit

[cgit](https://cgit.aaoth.xyz)

cgit web frontend to personal collection of git repositories.
pet projects, toy projects, all that fun stuff. as for now i'm keeping cgit for backup purposes,
main live actions will take place on gitea for now.

### fossil

[fossil](https://fsl.aaoth.xyz)

personal collection of fossil repositories. similar to all things git.

[learn more about fossil](https://fossil-scm.org)

## social

### honk

[honk](https://bloat.aaoth.xyz)

instance of honk, the most minimal and enlightened federated microblogging
service.

honk is amazing! it is written in go by ted unangst.

[source code of original honk](https://humungus.tedunangst.com/r/honk)

### xmpp

```

xmpp s2s: aaoth.xyz:5269 (default)
xmpp c2s: aaoth.xyz:5222 (default)
```

i have an xmpp server running prosody. if i know you and you need an account,
contact me to get an invite.

[learn more about xmpp](https://xmpp.org/)

### mumble

```

mumble: aaoth.xyz:64738 (default)
```

mumble is a self-hostable voice chat software. one can use it as a replacement
for proprietary things like discord. server is currently open, feel free to join
by using a mumble client. note that it is running off a small vps so don't be
surprized if it'll fail on you.

[learn more about mumble](https://mumble.info)

## other

### inks

[inks](https://inks.aaoth.xyz)

instance of inks, a link aggregator.

[source code of inks](https://humungus.tedunangst.com/r/inks)

### mail

```

smtp: mail.aaoth.xyz:587
smtp security: starttls
imap: mail.aaoth.xyz:993
imap security: ssl/tls
```

personal mail server. currently it is only used by me and there's no plan to add
support for registration. if you really want an account, contact me.

### ntfy

[ntfy](https://mail.aaoth.xyz)

```

ntfy: mail.aaoth.xyz
```

ntfy is a tool to easily send push notifications using simple http post request.
it also enables unified push, a way to make push notifications on android phones without
relying on google services.

ntfy works by creating topics. note that there are no restrictions on who can send what to
a topic, so you may treat topic name as a password.

(yes i forwarded ntfy to my mail domain just because i can. i have no plans on adding
webmail anyway).

[learn more about ntfy](https://ntfy.sh)
