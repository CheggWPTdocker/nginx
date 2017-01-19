FROM cheggwpt/alpine:3.5

# Install Nginx
# clean up the apk cache (no-cache still caches the indexes)
# Make the app directory
# install the fake sqs gem without docs
RUN apk --update --no-cache add \
	--virtual .nginx_service nginx && \
	rm -rf /var/cache/apk/*

# Add the www-data user and group, fail on error
RUN set -x ; \
	addgroup -g 82 -S www-data ; \
	adduser -u 82 -D -S -G www-data www-data && exit 0 ; exit 1 

# remove the default nginx config file
# Add the process control dirs for nginx and supervisord.  webroot is added by copy container confs
# own up the nginx control dir
# own up the webroot dir
# make it user/group read write
RUN rm -rf /etc/nginx/conf.d/default.conf && \
	mkdir -p /run/nginx /run/supervisord /webroot && \
	chown -R nginx:www-data /run/nginx && \
	chown -R www-data:www-data /webroot && \
	chmod -R ug+rw /webroot

# Expose the ports for nginx
EXPOSE 80 443

# expose the app volume - DON'T DO THIS HERE
# VOLUME ["/webroot"]

# Add the files
COPY container_confs /
