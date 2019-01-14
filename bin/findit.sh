#!/bin/bash
if [ "$#" -eq 1 ]; then
    dir='.'
    searchString="$1"
elif [ "$#" -eq 2 ]; then
    dir="$1"
    searchString="$2"
else
    echo "Usage: findit [dir] searchString" 1>&2
    return 2
fi

find "$dir" -iname "*$searchString*"
