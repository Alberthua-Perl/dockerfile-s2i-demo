FROM registry.lab.example.com/ubi7/ubi:latest

MAINTAINER hualongfeiyyy@163.com

COPY CentOS-Base.repo /etc/yum.repos.d/
COPY epel.repo /etc/yum.repos.d/
RUN yum install -y telnet iputils iproute httpd php php-mysql php-gd \
		&& yum clean all \
		&& mkdir -pv /web/

ADD loganalyzer.tar /web/
RUN touch /web/loganalyzer/config.php \
		&& chmod 666 /web/loganalyzer/config.php
COPY loganalyzer-view.conf /etc/httpd/conf.d/

EXPOSE 8881

CMD ["/usr/sbin/httpd","-DFOREGROUND"]

