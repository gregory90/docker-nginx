
Example Dockerfile:

FROM gregory90/nginx:latest

ADD default /etc/nginx/sites-available/default

CMD []
ENTRYPOINT ["nginx"]

