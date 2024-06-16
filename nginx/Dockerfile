FROM nginx:1.15.8

RUN rm -f /etc/nginx/conf.d/*

ADD nginx.conf /etc/nginx/nginx.conf

CMD /usr/sbin/nginx -g 'demon off;' -c /etc/nginx/nginx.conf
