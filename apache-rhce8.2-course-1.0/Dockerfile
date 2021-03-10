# Apache HTTP Server 2.4.6 container image
# Apply functions included virtual host, user
# authentication, access control, SSL and CGI.
# This container image is used to apply course
# docs.

FROM docker.io/library/centos:7.9.2009

MAINTAINER lhua "hualongfeiyyy@163.com"

RUN mkdir /etc/yum.repos.d/backup \
    && mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/backup \
    && mkdir -p /webapp/data/learnpath
COPY ./centos77-share.repo /etc/yum.repos.d
# backup all default repos files and use customized file

RUN yum install -y httpd mod_ssl perl-CGI \
    && yum clean all

COPY ./http-vhost-ssl.conf /etc/httpd/conf.d
ADD ./learnpath.tar /webapp/data/
# learnpath.tar includes all course docs, .auth_digest
# and cgi scripts.
# *NOTE* Just to replace tar ball to build new image.

COPY ./ca.crt /etc/pki/tls/certs
COPY ./server.crt /etc/pki/tls/certs
COPY ./server.key /etc/pki/tls/private
# copy ca files and key needed by SSL

EXPOSE 443

CMD ["/usr/sbin/httpd","-DFOREGROUND"]
