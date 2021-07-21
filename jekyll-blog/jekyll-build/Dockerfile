FROM docker.io/library/ubuntu:20.04
MAINTAINER alberthua hualongfeiyyy@163.com
ENV REFRESHED_AT=2021-07-15 \
    DEBIAN_FRONTEND=noninteractive
# That apt-get install dependency packages need interactive
# mode, but this mode shouldn't be used during image creating,
# so set this environment variable.

RUN apt-get -yqq update && \
    apt-get -yqq install ruby ruby-dev gcc g++ make nodejs && \
    gem install bundle kramdown-parser-gfm jekyll:3.9.1 && \
    apt-get clean    
# install gcc and c++ environment

VOLUME ["/data", "/var/www/html"]
WORKDIR /data

ENTRYPOINT ["jekyll", "build", "--destination=/var/www/html"]

# Note:
#   If you want to create image used as basic jekyll environment,
#   you should comment previous three directives, e.g, VOLUME, 
#   WORKDIR, ENTRYPOINT and rebuild it.
#   The Dockfile is to be used deploy jekyll build environment
#   to build blog just once.
#
#   According to jekyll version and blog configure, if you want to
#   build your blog, sometimes you will get error reports during
#   image creating, so install some .gem packages into image to 
#   resolv the issue.
 
