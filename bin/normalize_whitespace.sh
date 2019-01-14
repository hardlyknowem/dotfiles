#!/bin/bash
# Script to normalize whitespace in C Sharp files.
for filename in "$@"
do
    dos2unix "${filename}"; # Start with unix line endings
    expand -t 4 "${filename}" > /tmp/e && mv /tmp/e "${filename}"; # tabs to spaces
    sed -i '' 's/[[:space:]]\{1,\}$//' "${filename}"; # trailing whitsepace
    cat -s "${filename}" > /tmp/e && mv /tmp/e "${filename}"; # compress multiple blank lines
    unix2dos -n "${filename}" /tmp/e && mv /tmp/e "${filename}"; # back to CRLFs
done
