FROM php:7.0-apache
MAINTAINER Serge Ohl <docker@vizuweb.fr>

ENV VERSION 2.3
ENV VERSIONFULL 2.3.6
ENV TERM xterm

ENV ZPUSH_URL zpush_default

# Install utilis
RUN apt-get update && apt-get install -y wget

# Install zpush
RUN cd /var/www/html && \
	wget -O - "http://download.z-push.org/final/${VERSION}/z-push-${VERSIONFULL}.tar.gz" | tar --strip-components=1 -x -z && ls -lah

# Add zimbra backend
RUN cd /tmp && \
	wget -O - "http://downloads.sourceforge.net/project/zimbrabackend/Release62/zimbra62.tgz?use_mirror=freefr" | tar --strip-components=1 -x -z && \
	mv /tmp/z-push-2 /var/www/html/backend/zimbra

# Create directory for zpush
RUN mkdir -p /var/log/z-push && mkdir /var/lib/z-push
RUN chown www-data:www-data -R /var/lib/z-push /var/log/z-push /var/www/html

# Add vhost for zpush
COPY default-vhost.conf /etc/apache2/sites-enabled/000-default.conf

# Cleaning
RUN apt-get clean 

# Expose Apache
EXPOSE 80

COPY ./entrypoint.sh /opt/entrypoint.sh
RUN chmod +x /opt/entrypoint.sh
ENTRYPOINT ["/bin/bash", "/opt/entrypoint.sh"]