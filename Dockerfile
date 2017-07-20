FROM debian:stable
FROM nginx
FROM openjdk:8-jre

ADD ./nginx.conf /etc/nginx/conf.d/default
ADD /src /www
ADD ./logstash.conf /etc/nginx/conf.d/default

FROM docker.elastic.co/logstash/logstash:5.5.0 
RUN rm -f /usr/share/logstash/pipeline/logstash.conf 
#ADD pipeline/ /usr/share/logstash/pipeline/ 
ADD ./logstash.conf /usr/share/logstash/config/

#RUN wget  --no-check-certificate https://artifacts.elastic.co/downloads/logstash/logstash-5.5.0.deb

CMD ["sudo /usr/share/logstash/bin/logstash"]