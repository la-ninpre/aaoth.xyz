# aaoth.xyz

repo of aaoth.xyz [website][0] and [gemini capsule][1].

i have a lot of different creative projects so that i can't handle it in my
head. so i wish i'll be able to create some lightweight and simple website to
show as much of them as possible.

[0]:https://aaoth.xyz
[1]:gemini://aaoth.xyz

## implementation

website is built from markdown files by slightly modified [ssg][2] script.
[rssg][3] script generates rss feed from the blog page.
both scripts are included in the repository for ease of use.

i use a subset of markdown to maintain the ease of convertation to gemtext.

[2]:https://rgz.ee/ssg.html
[3]:https://rgz.ee/rssg.html

## dependencies

main dependency is a unix shell, some kind of coreutils (for awk, find, date
and others). other than that `lowdown` is needed to convert markdown to html and
gemini.

[lowdown home page](https://kristaps.bsd.lv/lowdown)

## history

firstly i've decided to use [jekyll][4] for this website.
but then i found out that it's fairly complex and adds a lot of unnecessary
layers of abstraction to my work.

also i used [this git hook][5] on my server-side git repository for
automatic deployment.

[4]:https://jekyllrb.com
[5]:https://jekyllrb.com/docs/deployment/automated/

## license

all site contents are licensed under
[creative commons attribution share-alike][6] license (see `LICENSE.CC-BY-SA`).

all supplemental code is licensed under an isc license (see `LICENSE.ISC`).

[6]:https://creativecommons.org/licenses/by-sa/4.0/
