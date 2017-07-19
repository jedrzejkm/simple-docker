FROM nginx

ADD ./nginx.conf /etc/nginx/conf.d/default
ADD /src /www