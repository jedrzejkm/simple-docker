FROM debian:stable
FROM nginx
FROM openjdk:8-jre

ADD ./nginx.conf /etc/nginx/conf.d/default
ADD /src /www
ADD ./logstash.conf /

RUN wget  --no-check-certificate https://artifacts.elastic.co/downloads/logstash/logstash-5.5.0.deb

CMD ["logstash", "-f /logstash.conf"]