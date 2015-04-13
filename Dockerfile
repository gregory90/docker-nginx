FROM gregory90/base:latest

ENV NGINX_VERSION 1.7.12-1~wheezy

RUN apt-key adv --keyserver pgp.mit.edu --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62
RUN echo "deb http://nginx.org/packages/mainline/debian/ wheezy nginx" >> /etc/apt/sources.list

RUN apt-get update && apt-get install -y nginx=${NGINX_VERSION} && rm -rf /var/lib/apt/lists/*

RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

RUN mkdir -p /app

ADD nginx/nginx.conf /etc/nginx/nginx.conf

ADD run.sh /app/run.sh

RUN chmod +x /app/run.sh

EXPOSE 80

CMD ["/app/run.sh"]
