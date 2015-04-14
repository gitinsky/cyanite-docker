FROM dockerfile/java:oracle-java8

MAINTAINER Daniel Podolsky <dp@gitinsky.com>

ENV PKG_NAME apache-cassandra-2.1.4
ENV PKG_SHA1 e7283e873403d2e9dac24531d58df21246e5cf3f

RUN \
  cd / \
  && apt-get update -y \
  && apt-get install -y lua5.2 leiningen \
  && git clone https://github.com/pyr/cyanite.git /tmp/cyanite \
  && cd /tmp/cyanite \
  && LEIN_ROOT=yes lein uberjar \
  && mkdir -vp /cyanite \
  && cp -v cyanite-*-standalone.jar /cyanite/ \
  && apt-get -y purge leiningen \
  && rm -rf /var/lib/apt/lists/*

ADD cyanite.yaml.template /cyanite/cyanite.yaml.template

ADD usr/local/bin/templater.lua /usr/local/bin/templater.lua
ADD usr/local/share/lua/5.2/fwwrt/simplelp.lua /usr/local/share/lua/5.2/fwwrt/simplelp.lua

ADD cyanite-autoconfig /cyanite-autoconfig

VOLUME ["/storage/logs"]

EXPOSE 2003 2080

CMD ["/cyanite-autoconfig"]
