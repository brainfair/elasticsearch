FROM ubuntu:20.04

ENV ES_PKG_NAME elasticsearch-7.15.2-amd64

RUN groupadd -g 1000 elasticsearch && useradd elasticsearch -u 1000 -g 1000

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  apt-transport-https \
  wget -y

RUN wget https://artifacts.elastic.co/downloads/elasticsearch/$ES_PKG_NAME.deb --no-check-certificate && \
  dpkg -i $ES_PKG_NAME.deb && \
  rm -rf $ES_PKG_NAME.deb

COPY elasticsearch.yml /etc/elasticsearch/

USER elasticsearch
CMD [ "/usr/share/elasticsearch/bin/elasticsearch" ]