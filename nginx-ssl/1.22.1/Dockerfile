# modified date: 
# 	- 2019-12-10: initial Dockerfile
# 	- 2023-01-16: update nginx and add client ssl authentication

FROM docker.io/library/centos:7.9.2009
MAINTAINER lhua "hualongfeiyyy@163.com"

# install nginx dependent packages
RUN yum repolist && \ 
		yum install -y gcc* && \
		yum install -y pcre-devel openssl openssl-devel && \
		yum clean all && \
		mkdir -p /application/nginx-1.22.1 && \
		useradd -u 1005 -M -s /sbin/nologin nginx
		# create nginx user to run nginx worker processes
	
# copy nginx source package to container rootfs
ADD nginx-1.22.1.tar.gz /tmp/

# make install nginx 
RUN cd /tmp/nginx-1.22.1 && \
		./configure --user=nginx --group=nginx --prefix=/application/nginx-1.22.1 \
	  	--with-http_stub_status_module --with-http_ssl_module && \
		make && \
		make install && \
		ln -s /application/nginx-1.22.1 /application/nginx && \
		mkdir /application/nginx/conf/extra && \
		mkdir /application/nginx/html/www && \
		mkdir /application/nginx/key
		# create virtual server, html and key directory.

# copy nginx configuration file, virtual server configuration file and certification file.
ADD nginx.conf /application/nginx/conf/
ADD www.conf /application/nginx/conf/extra/
ADD index.html /application/nginx/html/www/
ADD certs/server.key /application/nginx/key/
ADD certs/server.crt /application/nginx/key/
ADD certs/CA-center.crt /application/nginx/key/

EXPOSE 443

# Note: Don't run nginx as backend daemon
CMD ["/application/nginx/sbin/nginx", "-g", "daemon off;"]
