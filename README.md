# Quick puma benchmark

Let's say you want to test some puma server config.

This project is a simple isolated benchmark allowing you to experiment with various settings, eg.
- how much a request takes,
- min and max puma threads,
- number of client threads,
- number of simultaneous client connections.

## Running

```sh-session
$ docker build -t puma-bench .
Sending build context to Docker daemon 61.95 kB
[...]
Successfully built b64023150777
$ docker run --rm -e THROTTLE=1.5 -e THREADS_MIN=1 -e THREADS_MAX=10 puma-bench -t 3 -c 12
Using 1.5 s throttle.
Puma starting in single mode...
* Version 3.6.0 (ruby 2.3.1-p112), codename: Sleepy Sunday Serenity
* Min threads: 1, max threads: 10
* Environment: development
* Daemonizing...
Running 10s test @ http://localhost:9292
  3 threads and 12 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency     1.50s     2.40ms   1.51s    83.33%
    Req/Sec     4.83      7.92    30.00     86.96%
  60 requests in 10.01s, 5.57KB read
Requests/sec:      5.99
Transfer/sec:     569.17B
Memory usage:
 13m puma 3.6.0 (tcp://0.0.0.0:9292) [/]
```

## Environment variables

- *THROTTLE* -- number of seconds to sleep in every request (can be float)
- *THREADS_{MIN,MAX}* -- min and max number of puma threads
- *MAX_BACKLOG* -- maximum puma backlog (return 503 if greater than that; checked every request)

## Command line options

Are passed directly to [wrk](https://github.com/wg/wrk); here's a synopsis for
reference:

```
    -c, --connections <N>  Connections to keep open
    -d, --duration    <T>  Duration of test
    -t, --threads     <N>  Number of threads to use

    -s, --script      <S>  Load Lua script file
    -H, --header      <H>  Add header to request
        --latency          Print latency statistics
        --timeout     <T>  Socket/request timeout
    -v, --version          Print version details

  Numeric arguments may include a SI unit (1k, 1M, 1G)
  Time arguments may include a time unit (2s, 2m, 2h)
```
