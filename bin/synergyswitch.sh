#!/usr/bin/env bash
KARABINER=/Applications/Karabiner.app/Contents/Library/bin/karabiner

"${KARABINER}" select 0
tail -n 0 -f /usr/local/var/log/synergy.log |
    awk "/leaving screen/{system(\"${KARABINER} select 1\")} \
        /entering screen/{system(\"${KARABINER} select 0\")}"
