FROM httpd:alpine

MAINTAINER lhua "hualongfeiyyy@163.com"
MAINTAINER shw  "leo_wsy@outlook.com"

RUN apk update && apk add --no-cache apache2-ssl perl-cgi
COPY ./http-vhost-ssl.conf /usr/local/apache2/conf/extra/
COPY ./httpd.conf          /usr/local/apache2/conf/
ADD  ./learnpath.tar       /webapp/data/

COPY ./ca.crt     /usr/local/apache2/conf
COPY ./server.crt /usr/local/apache2/conf
COPY ./server.key /usr/local/apache2/conf

EXPOSE 443

CMD ["/usr/local/apache2/bin/httpd","-DFOREGROUND"]
