#! /bin/bash

while true
do
  npm run sync-peers > ~/sync.log
  npm run sync-markets >> ~/sync.log &
  npm  run sync-blocks >> ~/sync.log
  sleep 600
done
