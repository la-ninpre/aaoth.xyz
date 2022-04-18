#!/bin/sh -e

# interplanetary static site build system
# builds for both web and gemini

# powered by ssg, rssg and lowdown
# ssg and rssg are taken from rgz.ee and ssg is slightly modified

ssg="$PWD/bin/ssg"
rssg="$PWD/bin/rssg"

address="https://aaoth.xyz"
title="aaoth.xyz"
feed_title="$title - feed"

if [ -z "$AAOTH_ROOT" ]; then root="dst"; else root="$AAOTH_ROOT"; fi
if [ -z "$AAOTH_GEMROOT" ]; then gemroot="dst_gemini"; else root="$AAOTH_GEMROOT"; fi
en_src="en"
en_dst="$root"
en_gemdst="$gemroot"

feed_file="$root/rss.xml"
feed_gemfile="$gemroot/rss.xml"

build_site() {
	$ssg "$1" "$2" "$3" "$title" "$address"
    sh "$PWD/bin/gen.sh"
}

build_rss() {
	$rssg "$1/blog/index.md" "$feed_title" > "$feed_file"
    cp "$feed_file" "$feed_gemfile"
}

main() {
	[ "$1" = "-f" ] && {
	    rm -vrf "${en_dst:?}"/*
	    [ -f "$en_dst/.files" ] && rm -v "$en_dst/.files"

        rm -vrf "${en_gemdst:?}"/*
        [ -f "$en_gemdst/.files" ] && rm -v "$en_gemdst/.files"
	}

    [ -d "$root" ] || mkdir -p "$root"
    [ -d "$gemroot" ] || mkdir -p "$gemroot"
    [ -d "$en_dst" ] || mkdir -p "$en_dst"
    [ -d "$en_gemdst" ] || mkdir -p "$en_gemdst"

	build_site "$en_src" "$en_dst" "$en_gemdst"
	build_rss "$en_src"
}

main "$@"
