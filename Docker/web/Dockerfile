FROM nginx

RUN rm -f /etc/nginx/conf.d/*

COPY /Docker/web/nginx.conf /etc/nginx/conf.d/oremeshi.conf

CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf