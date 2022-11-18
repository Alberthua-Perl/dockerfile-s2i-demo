## Code Server v4.8.3 容器镜像构建

- 容器镜像构建与使用说明：

  - 由于使用本地 `Windows` 开发环境的 `VS Code` 构建与运行应用，获得的结果可能与云上的结果存在差异，因此构建该容器镜像更方便的保证开发环境的一致性。

  - 该容器镜像可提供的功能：

    - 基于 VS Code 的 `Web` 开发界面

    - 集成 `Golang v1.19.3` 语言开发环境

  - 使用该目录中的 `Dockerfile` 构建 Code Server v4.8.3 容器镜像，如下所示：

    ```bash
    $ tree -h .
      .
      ├── [103M]  code-server_4.8.3_amd64.deb
      ├── [1.9K]  Dockerfile
      ├── [ 17K]  oh-my-zsh-install.sh
      ├── [1.3K]  README.md
      └── [ 614]  sources.list
  
    $ sudo docker build -t golang-code-server:v1.1 .
    $ sudo docker run -d --name=golang-code-server -p 8080:8080 golang-code-server:v1.1
    # 使用构建的容器镜像运行容器，并登录访问 Web 界面。
    ```

  > 💥 注意：由于 `code-server_4.8.3_amd64.deb` 软件包的容量大小限制，可从  [百度网盘](https://pan.baidu.com/s/1ul4ZYZa1Cpmp_5fXxyGJtg) 下载，提取码为 `no8o`。

  - 该容器镜像可在 `Kubernetes` 或 `OpenShift` 集群外使用 `Docker` 或 `Podman` 先行测试，再将其导入指定的容器镜像仓库 `registry`。

- 参考链接：

  - [GitHub - coder/code-server](https://github.com/coder/code-server)

  - [code-server v4.8.0 docs](https://coder.com/docs/code-server/latest)

  - [dockerhub - golang](https://hub.docker.com/_/golang)

  - [云 vscode 搭建之使用容器化部署的方法](https://www.jb51.net/article/261704.htm)

  - [docker build时出现错误"debconf: unable to initialize frontend: Dialog"如何处理？](https://blog.51cto.com/u_15061952/3607022)
