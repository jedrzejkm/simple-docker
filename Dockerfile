FROM debian:stable

FROM nginx

ADD ./nginx.conf /etc/nginx/conf.d/default
ADD /src /www
ADD ./logstash.conf /

RUN echo "deb http://http.debian.net/debian jessie-backports main" | \
    tee --append /etc/apt/sources.list.d/jessie-backports.list > /dev/null
RUN apt-get update && install -y -t jessie-backports openjdk-8-jdk
RUN update-java-alternatives -s java-1.8.0-openjdk-amd64

RUN wget  --no-check-certificate https://artifacts.elastic.co/downloads/logstash/logstash-5.5.0.deb

RUN systemctl start logstash -f /logstash.conf
RUN systemctl enable logstash
RUN systemctl status logstash
