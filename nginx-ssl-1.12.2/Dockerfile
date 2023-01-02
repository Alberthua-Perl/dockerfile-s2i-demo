# Modified date: 2019-12-10

FROM centos:7.6.1810
MAINTAINER lhua "hualongfeiyyy@163.com"

# Install nginx dependent packages
RUN yum repolist \
	&& yum install -y gcc* \
	&& yum install -y pcre-devel openssl openssl-devel \
	&& yum clean all \
	&& mkdir -p /application/nginx-1.12.2 \
	&& useradd -u 1005 -M -s /sbin/nologin nginx
	# Create nginx user to run nginx worker processes
	
# Copy nginx source package to container rootfs
ADD nginx-1.12.2.tar.gz /tmp/

# Make install nginx 
RUN cd /tmp/nginx-1.12.2 \
	&& ./configure --user=nginx --group=nginx --prefix=/application/nginx-1.12.2 \
	       --with-http_stub_status_module --with-http_ssl_module \
	&& make \
	&& make install \
	&& ln -s /application/nginx-1.12.2 /application/nginx \
	&& mkdir /application/nginx/conf/extra \
	&& mkdir /application/nginx/html/www \
	&& mkdir /application/nginx/key
	# Create virtual server, html and key directory.

# Copy nginx configuration file, virtual server configuration file and certification file.
ADD nginx.conf /application/nginx/conf/
ADD www.conf /application/nginx/conf/extra/
ADD index.html /application/nginx/html/www/
ADD server.key /application/nginx/key/
ADD server.crt /application/nginx/key/

EXPOSE 443

# Note: Don't run nginx as backend daemon
CMD ["/application/nginx/sbin/nginx","-g","daemon off;"]
