#!/bin/sh

cd /root/project \
    && envsubst < mutagen.tpl.yml > mutagen.yml \
    && mutagen project start

stop() {
    cd /root/project && mutagen project terminate
    exit 0
}
trap stop SIGINT SIGTERM

while true
do
    sleep 1
done
