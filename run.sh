#!/bin/sh -x

puma -d -C app.rb
wrk http://localhost:9292 "$@"
