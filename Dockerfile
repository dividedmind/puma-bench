FROM alpine

RUN apk update && apk add nginx ruby
RUN apk add ruby-dev libc-dev gcc make
RUN gem install puma --no-doc
RUN apk add openssl openssl-dev luajit-dev
RUN \
  wget https://github.com/wg/wrk/archive/4.0.2.tar.gz -O- | tar zx && \
  cd wrk-4.0.2 && \
  make -j5 WITH_OPENSSL=/usr WITH_LUAJIT=/usr && \
  cp wrk /usr/local/bin && \
  cd / && rm -rf wrk-4.0.2

ENTRYPOINT ["/run.sh"]
ADD nginx.conf /etc/nginx/nginx.conf
ADD app.rb .
ADD run.sh .
