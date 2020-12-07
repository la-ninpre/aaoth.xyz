---
title: fossil export to git
author: la-ninpre
tags: [fossil, git, tutorial]
excerpt_separator: <!--more-->
---

i was trying to export my website repo to fossil using suggested method from
[fossil website][1]:

```
git fast-export --all | fossil import --git repo.fossil
```
[1]:https://www.fossil-scm.org/home/doc/trunk/www/inout.wiki

but i didn't like that fossil recognizes my email as username and so commit
messages user was `user@example.com` instead of `user`.

<!--more-->

i then read a bit about options of `git fast-export` and found `--anonymize`
flag. but it's results weren't satisfying either.

when i looked on a raw output of `git fast-export`, i noticed that commit author
is specified there as 

```
author user <user@example.com>
```

and then it's flashed in my head: why not pipe git export through sed and just 
replace the contents of `<>` with username instead of email.

so the final command looks like this:

```
git fast-export --all | \
    sed -E 's/^((author)|(committer))[[:blank:]]+([[:graph:]]+)[[:blank:]]+(<[[:alnum:]]+@[[:alnum:]]+\.[[:alnum:]]+>)/\1 \4 <\4>/' | \
    fossil import --git repo.fossil
```

and it converts

```
author user <user@example.com>
```

to 

```
author user <user>
```

which is odd, but fine for fossil import.

---

update: i tested this on a bigger repo with older history and found that this
regexp was not perfect, i updated it to handle situations like
`user@example.co.uk` and also names that consist of more than one word.

```
git fast-export --all | \
    sed -E 's/^((author)|(committer))[[:blank:]]+([[:graph:]]+([[:blank:]]+[[:graph:]]+)*)[[:blank:]]+(<[[:graph:]]+@[[:graph:]]+(\.[[:graph:]]+)+>)/\1 \4<\4>/' | \
    fossil import --git repo.fossil
```

it's veery evil looking horrible thing, but it works.
