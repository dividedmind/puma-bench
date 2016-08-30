FROM alpine

RUN apk update && apk add nginx ruby
RUN apk add ruby-dev libc-dev gcc make
RUN gem install puma --no-doc
