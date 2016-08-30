#!/bin/sh

mkdir /run/nginx
nginx
puma -d -C app.rb

(
  elapsed=0
  while true; do
    printf "%3ds  %s\r" $elapsed "`pumactl -C unix:///tmp/pumactl.sock stats | grep '{'`"
    elapsed=`expr $elapsed + 1`
    sleep 1
  done
) &

wrk http://localhost "$@"
kill %+

echo "Memory usage:"
ps -e -orss,args= | grep tcp://0.0.0.0:9292
