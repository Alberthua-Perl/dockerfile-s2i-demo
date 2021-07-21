#!/bin/bash
#
# Deploy customer Jekyll blog through container.
# Created by hualongfeiyyy@163.com on 2021-07-21.
# 

BLOG_DIR=$HOME/james_blog
if [[ -d $BLOG_DIR ]]; then
	echo "---> Target blog dir exists ..."
else
	echo "---> Target blog dir not exists, clone from github ..."
	git clone https://github.com/Alberthua-Perl/james_blog.git
fi

echo "---> Deploy Jekyll build container ..."
sudo podman pull quay.io/alberthua/jekyll-build:1.0
if [[ $? -eq 0 ]]; then
	sudo podman run \
		-v $BLOG_DIR:/data \
		--name james_blog \
		quay.io/alberthua/jekyll-build:1.0
	# The container is used to build jekyll blog once.
	# Builded blog is in /var/www/html which is container's volume.
else
	exit 1
fi

echo "---> Display Jekyll blog ..."
sudo podman pull quay.io/alberthua/apache2-base:1.0
if [[ $? -eq 0 ]]; then
	sudo podman run \
		-d -p 8080:80 \
		--volumes-from james_blog \
		--name  blog_viewer \
		quay.io/alberthua/apache2-base:1.0
	# --volumes-from option allow container to use james_blog
	# container volume which must be existed.
	# If remove james_blog container, /var/www/html volume will
	# be removed.
else
	exit 1
fi

if $(sudo netstat -tunlp | grep 8080 > /dev/null); then
	echo "--> Please visit http://localhost:8080"
	echo "--> Deploy successfully ..."
else
	echo "--> Please check any ERRORs ..."
fi

