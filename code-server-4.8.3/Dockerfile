FROM golang:1.19.3-bullseye

MAINTAINER lhua <hualongfeiyyy@163.com>

LABEL description='Code Server as cloud IDE like VS Code for Golang' \
      summary='Kubernetes extention will be installed including kubectl, helm, minikube and so on.'

ENV CODE_USER=godev \
    CODE_GROUP=godev \
    CODE_USER_HOME=/home/$CODE_USER \
    CODE_UID=11001 \
    GO_ROOT=/go

ARG DEBIAN_FRONTEND=noninteractive
# ignore debconfig error during docker build execution

COPY ./code-server_4.8.3_amd64.deb /opt
COPY ./oh-my-zsh-install.sh /opt
COPY ./sources.list /etc/apt/sources.list
# use mirror.aliyun.com sources instead of official sources

RUN apt-get update && \
    apt-get install -y sudo dialog apt-utils zsh && \
    apt-get install /opt/code-server_4.8.3_amd64.deb && \
    apt-get clean && \
    echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && \
    useradd -m -u $CODE_UID -s /bin/zsh $CODE_USER && \
    chown -R ${CODE_USER}:${CODE_GROUP} $GO_ROOT
    # install zsh and code-server deb package and create godev developer user

RUN cp /opt/oh-my-zsh-install.sh $CODE_USER_HOME && \
    chown $CODE_USER ${CODE_USER_HOME}/oh-my-zsh-install.sh && \
    chmod +x ${CODE_USER_HOME}/oh-my-zsh-install.sh
    # install oh-my-zsh under godev user

USER $CODE_UID
# must use specified user to install zsh and code-server extension,
# or installed under root account

RUN cd $CODE_USER_HOME && \
    ./oh-my-zsh-install.sh && \
    for EXTENTION in dracula-theme.theme-dracula redhat.vscode-yaml mhutchie.git-graph GitLab.gitlab-workflow; do \
      code-server --install-extension $EXTENTION; \
    done && \
    git config --global push.default simple && \
    git config --global credential.helper cache
    # config git user settings

WORKDIR ${GO_ROOT}/src
# use golang src directory as workdir

EXPOSE 8080

CMD ["/usr/bin/code-server", "--port", "8080", "--host", "0.0.0.0", "--auth", "none"]
# use code-server without password - none, also use password according to config.yaml

