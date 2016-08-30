#!/bin/sh

mkdir /run/nginx
nginx
puma -d -C app.rb

get_backlog()
{
  pumactl -C unix:///tmp/pumactl.sock stats | grep -Eo '"backlog": \d+' | sed -e 's/.* //'
}

[ -z "$MAX_BACKLOG" ] && MAX_BACKLOG=31337

(
  elapsed=0
  while true; do
    printf "%3ds  %s\r" $elapsed "`pumactl -C unix:///tmp/pumactl.sock stats | grep '{'`"
    elapsed=`expr $elapsed + 1`
    sleep 1
    if [ `get_backlog` -gt $MAX_BACKLOG ]; then
      echo "Backlog greater than $MAX_BACKLOG; throttling..."
      touch /throttle
    else
      rm -f /throttle
    fi
  done
) &

wrk http://localhost "$@"
kill %+

echo "Memory usage:"
ps -e -orss,args= | grep tcp://0.0.0.0:9292
