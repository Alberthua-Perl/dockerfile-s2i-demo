FROM docker.io/library/node:16.18.1-alpine3.15
# tech-exercise-1.0.10 application compatible with nodejs v16.18.1 NOT v18

MAINTAINER lhua <hualongfeiyyy@163.com>

ENV NODE_ROOT=/opt/tech-exercise-1.0.10

RUN npm install -g docsify-cli@4.4.3 && \
    mkdir $NODE_ROOT

ADD ./tech-exercise-1.0.10 $NODE_ROOT
# tech-exercise-1.0.10 from https://github.com/rht-labs/tech-exercise (TL500 Course)

WORKDIR $NODE_ROOT
EXPOSE 3000

CMD ["docsify", "serve", "./docs"]
