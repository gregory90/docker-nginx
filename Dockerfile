FROM gregory90/base:latest

# Install Nginx.
RUN \
  echo 'deb http://packages.dotdeb.org wheezy all\ndeb-src http://packages.dotdeb.org wheezy all' | tee /etc/apt/sources.list.d/dotdeb.list && \
  wget http://www.dotdeb.org/dotdeb.gpg && \
  apt-key add dotdeb.gpg && \
  DEBIAN_FRONTEND=noninteractive apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y nginx && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  chown -R www-data:www-data /var/lib/nginx

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# http
EXPOSE 80
