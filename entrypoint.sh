#!/bin/bash

# Add local user
# Either use the LOCAL_USER_ID if passed in at runtime or we
# fallback to uid 9001 --> because it's OVER NINE THOUSAAAAAND! :D
USER_ID=${LOCAL_USER_ID:-9001}
echo "Starting with UID : $USER_ID"
# Add docker group to default user
useradd --shell /bin/bash -u $USER_ID -c "" -m user
export HOME=/home/user

chown user:user /opt/slides/reveal.js/out -R
chown user:user /opt/slides/reveal.js/md -R

# Source default env vars needed it there are any
if [ -d '/opt/slides/etc/default'  ]; then
    for f in /opt/slides/etc/default/*; do
        [ -f "$f" ] && . "$f"
    done
fi

# Runs additional entry point scripts needed by individual
# projects
if [ -d /opt/slides/entrypoint.d ]; then
    for f in /opt/slides/entrypoint.d/*; do
        [ -f "$f" ] && . "$f"
    done
fi

exec /usr/local/sbin/pid1 -u user -g user "$@"
