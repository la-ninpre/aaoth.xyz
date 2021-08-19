#!/bin/sh -ex

_img_dirs="$( find . -maxdepth 1 -type d | sed -e '1d' -e 's/^\.\///' )"
_thumb_size="835x"
_thumbs_dir="thumbs"
_force_render=0

usage() {
    echo "usage: $0 [-f|--force]"
}

[ -n "$1" ] && \
    case $1 in
        -f|--force)
            _force_render=1
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            usage
            exit 1
            ;;
    esac

for dir in $_img_dirs
do
    cd "./$dir" || exit 1

    mkdir -p "$_thumbs_dir"

    _imgs="$(find . -maxdepth 1 \
        -iname "*.jpg" -or \
        -iname "*.jpeg" -or \
        -iname "*.gif" -or \
        -iname "*.png" -type f | cut -b 3-)"
    for _img in $_imgs
    do
        _ext="${_img##*.}"
        _name="${_img%%.*}"
        _thumb="./$_thumbs_dir/${_name}_thumb.${_ext}"

        [ "$_force_render" -eq 1 ] || [ ! -f "$_thumb" ] && \
        {
            # when compressed, gifs look ugly, so just copy them
            # i know this is bad, but i'll adress it later
            [ "$_ext" = "gif" ] && \
                echo "copied $1 to $_thumb" && \
                cp "$_img" "$_thumb" && continue

            echo "creating thumbnail for $_name..."
            convert "$_img" -resize "$_thumb_size" "$_thumb"
        }
    done

    cd ".."

done

