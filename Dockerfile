FROM debian:stable

FROM nginx

ADD ./nginx.conf /etc/nginx/conf.d/default
ADD /src /www
ADD ./logstash.conf /
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | \
  sudo tee /etc/apt/sources.list.d/webupd8team-java.list
RUN echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | \
  sudo tee -a /etc/apt/sources.list.d/webupd8team-java.list
RUN sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
RUN sudo apt-get update && -y install oracle-java8-installer

RUN wget  --no-check-certificate https://artifacts.elastic.co/downloads/logstash/logstash-5.5.0.deb

RUN systemctl start logstash -f /logstash.conf
RUN systemctl enable logstash
RUN systemctl status logstash
