FROM gregory90/base:latest

# Set correct environment variables.
ENV HOME /root

# Remove ssh
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Install Nginx.
RUN \
  DEBIAN_FRONTEND=noninteractive apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common python-software-properties && \
  add-apt-repository -y ppa:nginx/stable && \
  DEBIAN_FRONTEND=noninteractive apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y nginx && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  chown -R www-data:www-data /var/lib/nginx

RUN mkdir /etc/service/nginx
ADD nginx.sh /etc/service/nginx/run
RUN chmod +x /etc/service/nginx/run

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
