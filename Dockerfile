FROM thoughtbot/elixir:1.3.0
MAINTAINER Blake Williams <blake@thoughtbot.com>
ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.UTF-8

RUN apt-get update && apt-get install -y --no-install-recommends \
      postgresql-client

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash \
 && apt-get install -y nodejs

RUN mkdir /app
WORKDIR /app
ADD mix.* /app/
RUN mix local.rebar
RUN mix local.hex --force
RUN mix deps.get
ADD . /app/
RUN mix compile

CMD mix phoenix.server
