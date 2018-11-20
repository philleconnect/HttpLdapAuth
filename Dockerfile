FROM debian:stretch-slim

ENV DEBIAN_FRONTEND noninteractive

ENV VERSION "1"

USER root

MAINTAINER Dirk Winkel

RUN apt-get update && apt-get install -y nginx-full libpam-ldap

COPY debconf_libnss-ldap /root/

COPY default /etc/nginx/sites-available/
#COPY pam.d_nginx /etc/pam.d/nginx
COPY pam_ldap.conf /root/
RUN usermod -aG shadow www-data

RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf

#RUN echo "#!/bin/sh\n" >> run.sh
#RUN echo "nginx\n" >> /run.sh && chmod +x /run.sh

EXPOSE 80

COPY entrypoint.sh /

#CMD "/bin/bash"
CMD "./entrypoint.sh"
#CMD ["./run.sh"]
#CMD service php7.0-fpm start && nginx
