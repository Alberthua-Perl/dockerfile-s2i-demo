## Code Server v4.8.3 容器镜像构建

- 文档说明：

  - `Red Hat OpenShift` 中使用 `Red Hat Code Ready Workspace` 作为 PaaS 平台中的实时 IDE 开发平台，可兼容众多开发语言。

  - 该示例的目的在于构建类似于 Red Hat Code Ready Workspace 的容器化 Golang IDE 开发平台。

  - 可使用此 Golang IDE 开发平台提供与本地 `Microsoft VS Code` 平台相同的功能，并可实现实时登录开发环境与远程代码仓库的一致性。

- 容器镜像构建与使用：

  - 该容器镜像可提供的功能：

    - 👉 基于 `VS Code` 的 `Web UI` 开发界面

    - 👉 集成 `Golang v1.19.3` 语言开发环境

  - 使用该目录中的 `Dockerfile` 构建 `Code Server v4.8.3` 容器镜像，如下所示：

    ```bash
    $ tree -h .
      .
      ├── [103M]  code-server_4.8.3_amd64.deb
      ├── [1.9K]  Dockerfile
      ├── [ 17K]  oh-my-zsh-install.sh
      ├── [1.3K]  README.md
      └── [ 614]  sources.list
  
    $ sudo docker build -t golang-code-server:v1.1 .
    # 在当前目录上下文中构建
    $ sudo docker run -d --name=golang-code-server -p 8080:8080 golang-code-server:v1.1
    # 使用构建的容器镜像运行容器，并登录访问 Web 界面。
    ```

  > 💥 注意：由于 `code-server_4.8.3_amd64.deb` 软件包的容量大小限制无法上传至 GitHub 中，可从  [百度网盘](https://pan.baidu.com/s/1ul4ZYZa1Cpmp_5fXxyGJtg) 下载，提取码为 `no8o`。

  - 该容器镜像可在 `Kubernetes` 或 `OpenShift` 集群外使用 `Docker` 或 `Podman` 先行测试，再导入容器镜像仓库 `registry`，用于后续的部署使用。

- 参考链接：

  - [GitHub - coder/code-server](https://github.com/coder/code-server)

  - [code-server v4.8.0 docs](https://coder.com/docs/code-server/latest)

  - [dockerhub - golang](https://hub.docker.com/_/golang)

  - [云 vscode 搭建之使用容器化部署的方法](https://www.jb51.net/article/261704.htm)

  - [docker build 时出现错误 "debconf: unable to initialize frontend: Dialog" 如何处理？](https://blog.51cto.com/u_15061952/3607022)
