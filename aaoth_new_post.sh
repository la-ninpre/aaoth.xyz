#!/bin/sh

SITE_DIR="$HOME/Documents/aaoth.xyz"
POSTS_DIR="$SITE_DIR/_posts"

DATE_SHORT=$(date -I)
DATE_LONG=$(date -Isec)

usage() {
    echo "usage:"
    echo "  $0 [OPTIONS]"
    echo
    echo "options:"
    echo "  -t, --title <title>"
    echo "          specify new post title"
    echo "  -g, --tags <tags>"
    echo "          specify new post tags"
    echo "  -h, --help"
    echo "          print usage information"
}

read_title() {
    echo -n "new post title: "
    read TITLE
}

read_tags() {
    echo -n "new post tags: "
    read TAGS
}

create_tag_page() {
    cat <<- TAG > "$SITE_DIR/tags/$1.md"
---
layout: tagsort
tag: $1
title: "tags: $1"
permalink: /tags/$1/
---
TAG
}

cd $SITE_DIR

# if there are no arguments specified, run interactively
if [ $# -gt 0 ]
then
    while [ -n "$1" ]
    do
        case "$1" in
            --title|-t)
                shift
                TITLE=$1
                ;;
            --tags|-g)
                shift
                TAGS=$1
                ;;
            --help|-h)
                usage
                exit 2
                ;;
            *)
                usage
                exit 1
                ;;
        esac
        shift
    done
fi

[ -z "$TITLE" ] && read_title
[ -z "$TITLE" ] && echo "title could not be empty" && exit 1

[ -z "$TAGS" ] && read_tags
[ -z "$TAGS" ] && echo "specify at least one tag" && exit 1

TITLE_FILE=$(echo $TITLE | tr '[A-Z]' '[a-z]' | sed 's/ /-/g')

POST_FILENAME="$POSTS_DIR/$DATE_SHORT-$TITLE_FILE.md"

for _tag in $TAGS
do
    [ ! -f "./tags/$_tag.md" ] \
        && echo "tag $_tag is not present, creating one" \
        && create_tag_page $_tag
done

# template is currently hardcoded
cat <<-EOF > "$POST_FILENAME"
---
title: $TITLE
date: $DATE_LONG
author: la-ninpre
tags: $TAGS
---

<!--more-->

EOF

nvim -c "normal 6jo" -c "startinsert" $POST_FILENAME
