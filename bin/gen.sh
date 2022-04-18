#!/bin/sh -ex

srcdir="./en/visual"
categories="drawings photos logos renders"
index="index.md"

list_images() {
    # $1 -- directory
    find "$1" -type f \
        | grep -E "(\.jpe?g)|(\.png)|(\.gif)"
}

append_image() {
    # $1 -- directory
    c_index="$1/$index"
    while read -r i; do
        i=$(basename "$i")
        if ! (grep "$i" "$c_index"); then
            printf "\n" >> "$c_index"
            echo "![${i%%.*}]($i)" >> "$c_index"
        fi
    done
}

cd "$srcdir" || exit 1
for c in $categories;
do
    list_images "$c" | append_image "$c"
done
